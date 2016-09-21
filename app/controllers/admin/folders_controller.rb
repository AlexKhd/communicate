module Admin
  class FoldersController < Admin::ApplicationController
    before_action :set_folder, only: [:show, :destroy]

    def index
      Folder.find_each(&:save)
      @folders = Folder.paginate(page: params[:page], per_page: 30).order(id: :desc)
    end

    def show

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
end
