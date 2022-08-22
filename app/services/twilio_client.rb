class TwilioClient
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def send_message(user)
    twilio_phone_no = +17472452829

    client.messages.create(
      from: twilio_phone_no,
      to: user.phone,
      body: "Hey friend!"
    )
  end

  private

  def account_sid
    Rails.application.credentials.dig(:account_sid)
  end

  def auth_token
    Rails.application.credentials.dig(:auth_token)
  end
end