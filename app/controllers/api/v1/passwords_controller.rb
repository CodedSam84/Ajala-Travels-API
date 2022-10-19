class Api::V1::PasswordsController < Devise::PasswordsController
  def password_reset_instructions
    self.resource = resource_class.send_reset_password_instructions(password_params)

    if successfully_sent?(resource)
      render json: { success: true }, status: :ok
    else
      render json: { error: "Something went wrong..." }, status: :unprocessable_entity
    end
  end

  def update
    
  end

  private

  def password_params
    params.permit(:email)
  end
end