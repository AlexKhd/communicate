class UserMailer < ApplicationMailer
  default from: 'admin'

  def news_email(user, post)
    @user = user
    @post  = post
    mail(to: "#{@user.name} <#{@user.email}>", subject: 'Новые фотографии',
         template_path: 'user_mailer', template_name: 'news_email')
  end

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/'
    mail(to: user.email, subject: 'New user registered',
         template_path: 'user_mailer', template_name: 'welcome_email')
  end
end
