module Admin
  class ChatroomsController < Admin::ApplicationController

    def destroy
      @chatroom = Chatroom.friendly.find(params[:id])
      @chatroom.destroy
      respond_to do |format|
        format.html { redirect_to admin_root_path, notice: 'Chatroom was deleted' }
        format.json { head :no_content }
      end
    end

    private
    
      def chatroom_params
        params.require(:chatroom).permit(:name)
      end
  end
end
