class Api::V1::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      render json: { success: true }, status: :ok
    else
      render json: { error: resource.errors }, status: :unprocessable_entity
    end
  end

  def resend_email
    user = User.find_by_email(params[:email])

    if user
      user.send_confirmation_instructions
      render json: { success: true }, status: :ok
    else
      render json: { error: "Cannot find user" }, status: :unprocessable_entity
    end
  end
end