module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :destroy]

    def index
      @users = User.all
    end

    def edit
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          bypass_sign_in(@user == current_user ? @user : current_user)
          format.html { redirect_to admin_users_path, notice: 'Your profile was updated.' }
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      # authorize! :delete, @user
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: 'User was deleted.' }
        format.json { head :no_content }
      end
    end

    private

    def set_user
      @user = User.friendly.find(params[:id])
    end
  end
end
