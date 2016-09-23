class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.gmail_user_name_mailer
end
