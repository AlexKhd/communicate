class AdminMailer < ApplicationMailer
  default from: 'admin'

  def notify_message(action, data)
    mail(to: Rails.application.secrets.admin_email, subject: action,
      body: data)
  end
end
