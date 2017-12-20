class SessionsController < ApplicationController

  skip_before_action :require_admin!

  def index
    if current_session.present?
      render json: { success: true, data: { token: current_session.token } }
    else
      render json: { success: false, error: 'Token does not exist' }
    end
  end

end
