class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      render json: { success: true }
    else
      clean_up_passwords resource
      set_minimum_password_length
      
      render json: {error: resourse.errors.messages}
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
  end
end