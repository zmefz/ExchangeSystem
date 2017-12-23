class UsersController < ApplicationController
  skip_before_action :require_admin!, only: [:show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    render json: { success: true, data: get_data_for_all_users }, status: :ok
  end

  def show
    if @user
      render json: { success: true, data: get_data_for_user(@user) }, status: :ok
    else
      render json: { success: false, error: 'User not found' }, status: :not_found
    end
  end

  def create
    @user = UserResolver.resolve(user_params)

    render json: { success: true, data: get_data_for_user(@user) }, status: :created
  rescue => errors
    render json: { success: false, errors: errors, message: errors.full_messages }, status: :unprocessable_entity
  end

  def update
    if @user.update(user_params)
      render json: { success: true, data: get_data_for_user(@user) }, status: :ok
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
      @user = if params[:id] == 'me'
        current_user
      else
        User.find(params[:id])
      end
    end

    def user_params
      params.require(:user).permit(:role, :prefferedCurrency, :firstname, :lastname, :passport, :password)
    end

    def get_data_for_all_users
      User.all.map { |user| get_data_for_user(user) }
    end

    def get_data_for_user(user)
      {
        id:         user.id,
        first_name: user.firstname,
        last_name:  user.lastname,
        is_admin:   user.admin?,
        transactions: {
          day_amount:      user.transactions.daily.amount,
          all_time_amount: user.transactions.amount,
          all_time_count:  user.transactions.count,
        },
        before_limit: MAX_DAILY_AMOUNT - user.transactions.daily.amount,
      }
    end
end
