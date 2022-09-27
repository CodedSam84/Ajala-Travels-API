class Api::V1::AuthenticationsController < ApplicationController
  include HTTParty

  def google
    if params[:access_token]
      url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{params[:access_token]}"
      response = HTTParty.get(url)
      parsed_response = JSON.parse(response)

      user = User.find_by_email(parsed_response[:email])

      if user
        user.generate_auth_token
        user.save
        render json: user, status: :ok
      else
        user = User.new(
        email: parsed_response[:email],
        fullname: parsed_response[:name],
        image: parsed_response[:picture],
        uid: parsed_response[:kid],
        provider: "Google"
      )

      render_response
      end

    else
      render json: { error: "Invalid google token", success: false }, status: :unprocessable_entity
    end
  end

  def sign_in
    user = User.find_by_email(params[:email])

    if user&.user.valid_password?(params[:password])
      render_response
    else
      render json: { error: "Invalid email or password", success: false }, status: :unauthorized
    end
  end

  def sign_out
    user = User.find_by(access_token: params[:access_token])
    user.generate_auth_token
    user.save
    render json: { success: true }, status: :ok
  end

  private

  def render_response
    user.generate_auth_token

    if user.save
      render json: user, status: :ok
    else
      render json: { error: user.errors.messages, success: false }, status: :unprocessable_entity
    end
  end
end