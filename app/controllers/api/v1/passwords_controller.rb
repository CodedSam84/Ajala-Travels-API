class Api::V1::PasswordsController < Devise::PasswordsController
  def password_reset_instructions
    self.resource = resource_class.send_reset_password_instructions(password_params)

    if successfully_sent?(resource)
      render json: { success: true }, status: :ok
    else
      render json: { error: "Something went wrong...." }, status: :unprocessable_entity
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(password_params)

    if resource.errors.empty?
      render json: { success: true }, status: :ok
    else
      render json: { error: resource.errors }, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:email, :password, :password_confirmation, :reset_password_token)
  end
end