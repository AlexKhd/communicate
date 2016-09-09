class UserMailer < ApplicationMailer
  default from: 'admin'

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/'
    mail(to: user.email, subject: 'New user registered',
         template_path: 'user_mailer', template_name: 'welcome_email')
  end
end
