class SessionsController < ApplicationController

  skip_before_action :require_admin!, only: [:create]

  def create
    if current_session.present?
      render json: { success: true, data: { token: current_session.token } }
    else
      render json: { success: false, error: 'Token does not exist' }
    end
  end

  def destroy
    current_session.delete
    render json: { success: true }
  end

end
