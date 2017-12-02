require "UserResolver"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_user!
  helper_method :current_user

  def current_user
    @_current_user ||= current_session.user if current_session.present?
  end

  def current_session
    @_current_session ||= find_session || create_session
  end

  def require_user!
    current_user.present?
  end

  private

  def find_session
    Session.find_by(token: request.headers["session-token"]) if request.headers["session-token"]
  end

  def create_session
    Session.create(user: find_user_by_params)
  end

  def find_user_by_params
    UserResolver.resolve(user_data)
  rescue => creating_errors
    render json: { success: false, error: creating_errors }
  end

  def user_data
    params.require(:user).permit!
  end

end
