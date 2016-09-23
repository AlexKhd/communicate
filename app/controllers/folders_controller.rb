class FoldersController < ApplicationController
  before_action :redirect_users
  before_action :set_folder
  after_action :notify_message, only: [:show]

  def show
    @pictures = @folder.pictures.paginate(page: params[:page], per_page: 10)
  end

  def destroy

  end

  private
    def notify_message
        user = current_user
        AdminMailer.notify_message('user visited a folder', @folder.name + ' ' + user.name).deliver_now
    end

    def picture_params
      params.require(:folder).permit(:name)
    end

    def set_folder
      @folder = Folder.friendly.find(params[:id])
    end
end
