class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    if current_user
      render json: { success: true }, status: :created
    else
      render json: { success: false, error: 'User not found' }, status: :not_found
    end
  end

  def create
    @user = UserResolver.resolve(user_params)

    render json: { success: true }, status: :created
  rescue => errors
    render json: { success: false, errors: errors, message: errors.full_messages }, status: :unprocessable_entity
  end

  def update
    if @user.update(user_params)
      render json: { success: true }, status: :ok
    else
      render json: { success: false, errors: @user.errors, message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render json: { success: true }, status: :ok
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:role, :prefferedCurrency, :firstname, :lastname, :passport, :password)
    end
end
