require "UserResolver"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  before_action :require_user!, :require_admin!
  helper_method :current_user, :current_session

  def current_user
    @_current_user ||= current_session.user if current_session.present?
  end

  def current_session
    @_current_session ||= find_session || create_session
  end

  def require_admin!
    unless current_user.admin?
      render json: { success: false, error: 'Access denied' }, status: :unauthorized
    end
  end

  def require_user!
    unless current_user.present?
      render json: { success: false, error: 'User is not provided' }, status: :unauthorized
    end
  end

  private

  def find_session
    Session.find_by(token: request.headers["session-token"]) if request.headers["session-token"]
  end

  def create_session
    Session.create(user: find_user_by_params) if find_user_by_params
  end

  def find_user_by_params
    UserResolver.resolve(user_data)
  rescue => creating_errors
    render json: { success: false, error: creating_errors }
  end

  def user_data
    params.require(:user).permit! if params[:user].present?
  end

end
