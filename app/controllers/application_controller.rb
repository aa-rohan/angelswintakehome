class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authenticate_request!
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = JsonWebToken.decode(header)
    @current_user = User.find(decoded[:user_id])
  rescue StandardError
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
