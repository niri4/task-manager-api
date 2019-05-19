class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request

  def create
    user = User.new(user_params)
    if user.save
      auth = AuthenticateUser.call(user.email, params[:user][:password])
      accessToken = "Authorization " + auth.result
      render json: {message: 'User successfully created', user: user, access_token: accessToken}, status: :created
    else
      render json: {error: user.errors.mesages}, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
