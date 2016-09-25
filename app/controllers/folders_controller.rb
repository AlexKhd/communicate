class FoldersController < ApplicationController
  before_action :redirect_users
  before_action :set_folder
  after_action :notify_admin, only: [:show]

  def show
    @pictures = @folder.pictures.paginate(page: params[:page], per_page: 10)
  end

  def destroy

  end

  private
    def notify_admin
      admin = User.find_by_email(Rails.application.secrets.admin_email)
      admin.update_attribute(:news_email_sent_at, Time.now) if admin.news_email_sent_at.nil?
      if admin.news_email_sent_at < 5.minutes.ago
        AdminMailer.notify_message('user visited a folder', @folder.name + ' ' + current_user.name).deliver_now
        admin.update_attribute(:news_email_sent_at, Time.now)
      end
    end

    def picture_params
      params.require(:folder).permit(:name)
    end

    def set_folder
      @folder = Folder.friendly.find(params[:id])
    end
end
