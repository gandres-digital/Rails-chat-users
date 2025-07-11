class ApplicationController < ActionController::API
  before_action :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = JwtService.decode(token)
    if decoded && decoded['user_id']
      @current_user = User.find_by(id: decoded['user_id'])
    else
      render json: { error: 'No autorizado' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
