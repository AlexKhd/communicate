module Admin
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout 'admin'

    before_action :redirect_if_not_admin

    private

    def redirect_if_not_admin
      redirect_to root_path, notice: 'Access denied' unless current_user && current_user.admin?
    end
  end
end
