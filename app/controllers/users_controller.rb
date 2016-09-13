class UsersController < ApplicationController
  before_action :set_user, only: [:finish_signup]

  def show
    @user = params[:id].nil? ? current_user : User.friendly.find(params[:id])
    t = Rails.application.secrets.admin_email
    current_user.set_admin if current_user && current_user.email == t
  end

  def finish_signup
    # current_user.skip_confirmation!
    if request.patch? && params[:user] # && params[:user][:email]
      if current_user.update(user_params)
        # current_user.skip_confirmation!
        sign_in(current_user, bypass: true)
        redirect_to root_path, notice: t(:profile_updated)
      else
        @show_errors = true
      end
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
