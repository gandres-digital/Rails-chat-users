class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user_from_token!, only: [:create, :destroy]
  respond_to :json

  # POST /users/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    token = JwtService.encode(user_id: resource.id)
    render json: { user: resource, token: token, message: 'Sesión iniciada correctamente.' }, status: :ok
  end

  # DELETE /users/sign_out
  def destroy
    sign_out(resource_name)
    render json: { message: 'Sesión cerrada correctamente.' }, status: :ok
  end
end
