class FoldersController < ApplicationController
  before_action :redirect_users
  before_action :set_folder

  def show
    @pictures = @folder.pictures.paginate(page: params[:page], per_page: 10)
  end

  def destroy

  end

  private
    def picture_params
      params.require(:folder).permit(:name)
    end

    def set_folder
      @folder = Folder.friendly.find(params[:id])
    end
end
