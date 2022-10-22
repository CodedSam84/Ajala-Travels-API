class UserMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  layout 'mailer'

  def confirmation_instructions(record, token, opts={})
    mail = super
    mail.subject = "Confirm your email address"
    mail
  end
end