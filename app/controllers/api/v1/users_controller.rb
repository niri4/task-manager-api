class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:new, :create]

  def index
    render json: { user: @current_user }, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      auth = AuthenticateUser.call(user.email, params[:user][:password])
      accessToken = "Authorization " + auth.result
      render json: {message: 'User successfully created', user: user, access_token: accessToken}, status: :created
    else
      render json: {error: user.errors.messages}, status: :unprocessable_entity
    end
  end

  def new
    render json: {user: User.new}, status: :ok
  end

  def update
     @current_user.assign_attributes(user_params)
    if @current_user.save
      auth = AuthenticateUser.call(@current_user.email, params[:user][:password])
      accessToken = "Authorization " + auth.result
      render json: {message: 'User successfully created', user: @current_user, access_token: accessToken}, status: :ok
    else
      render json: {error: @current_user.errors.messages}, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
