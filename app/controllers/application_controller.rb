require "UserResolver"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  before_action :require_user!, :require_admin!
  helper_method :current_user, :current_session

  rescue_from StandardError do |error|
    render json: { success: false, error: error }
  end

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
      return false
    end
  rescue => error
    render json: { success: false, error: error }
    return false
  end

  private

  def find_session
    Session.find_by(token: request.headers["session-token"]) if request.headers["session-token"]
  end

  def create_session
    Session.create(user: find_user_by_params) if find_user_by_params
  end

  def find_user_by_params
    @_user ||= UserResolver.resolve(user_data)
  end

  def user_data
    if params[:user].present?
      params.require(:user).permit!
    else
      {}
    end
  end

end
