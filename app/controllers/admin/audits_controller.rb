module Admin
  class AuditsController < Admin::ApplicationController

    def index
      @audits = Audit.paginate(page: params[:page], per_page: 30).order(id: :desc)
    end

    def destroy
      @audit = Audit.find(params[:id])
      @audit.destroy
      respond_to do |format|
        format.html { redirect_to admin_audits_path, notice: 'Record was deleted' }
        format.json { head :no_content }
      end
    end
  end
end
