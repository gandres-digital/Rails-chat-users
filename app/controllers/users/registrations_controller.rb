class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user_from_token!, only: [:create]
  respond_to :json

  # POST /users
  def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      if resource.active_for_authentication?
        render json: { user: resource, message: 'Registrado correctamente.' }, status: :created
      else
        render json: { user: resource, message: 'Registrado pero inactivo.' }, status: :created
      end
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
