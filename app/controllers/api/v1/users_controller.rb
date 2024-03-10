class Api::V1::UsersController < ApplicationController
  def signup
    user = User.new(user_params)
    if user.save
      head :no_content
    else
      render json: { error: 'There was an issue signing up' }, status: :unprocessable_entity
    end
  end

  def signin
    user = User.find_by_email(params[:auth][:email])
    if user&.authenticate(params[:auth][:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :country)
  end
end
