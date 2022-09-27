module Authenticate
  def authenticate_with_token!
    render json: { error: "You are not authorized", success: false }, status: :unauthorized unless current_user
  end

  def current_user
    @current_user = User.find_by(auth_token: params[:access_token])
  end
end