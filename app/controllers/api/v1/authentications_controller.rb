class Api::V1::AuthenticationsController < ApplicationController
  include HTTParty

  before_action :authenticate_with_token!, only: [:sign_out]

  def google
    if params[:access_token]
      url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{params[:access_token]}"
      response = HTTParty.get(url)
      user_data = response.parsed_response

      unless user_data.include? "error_description"
        user = User.find_by_email(user_data["email"])
      
        if user
          return_user
        else
          new_google_user(user_data)
          render_response
        end
      else
        render json: { error: "Access denied!", success: false }, status: :unprocessable_entity
      end
    else
      render json: { error: "Google access token expected", success: false }, status: :unprocessable_entity
    end
  end

  def sign_in
    begin
      @user = User.find_by_email(params[:email])

      if @user && @user.valid_password?(params[:password])
        render_response
      else
        render json: { error: "Wrong password", success: false }, status: :unauthorized
      end
    rescue
      render json: { error: "No record found!", success: false }, status: :unprocessable_entity
    end
  end

  def sign_out
    user = User.find_by(auth_token: params[:access_token])
    user.generate_auth_token
    user.save
    render json: { success: true }, status: :ok
  end

  private

  def render_response
    @user.generate_auth_token

    if @user.save
      render json: @user, status: :ok
    else
      render json: { error: @user.errors.messages, success: false }, status: :unprocessable_entity
    end
  end

  def new_google_user(user_data)
    @user = User.new(
      email: user_data["email"],
      password: Devise.friendly_token[0,20],
      fullname: user_data["name"],
      image: user_data["picture"],
      uid: user_data["kid"],
      provider: "Google"
    )
  end

  def return_user
    user.generate_auth_token
    user.save
    render json: user, status: :ok
  end
end