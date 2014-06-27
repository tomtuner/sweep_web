class UserMailer < ActionMailer::Base
  default from: "no-reply@sweepevents.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  
  def registration_confirmation(user)
    @user = user
    mail to: "#{user.first_name} #{user.last_name} <#{user.email}>", :subject => "Sweep Registration Confirmation!"
  end

  def email_confirmation(user)
    @user = user
    mail to: "#{user.first_name} #{user.last_name} <#{user.email}>", :subject => "Sweep Temporary Password!"
  end
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Sweep Password Reset"
  end
end
