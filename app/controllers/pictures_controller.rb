class PicturesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :connect, only: [:create, :destroy]
  before_action :redirect_users, except: :index

  def index
    if logged_in?
      connect
      @picture = current_user.pictures.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      create_user_public_folder(current_user, 'MyPublicFolder') if !Folder.exists?(user_id: current_user.id, name: 'MyPublicFolder')
    end
  end

  def create
    user = current_user
    @picture = Picture.new(picture_params)
    @picture.set_attributes
    current_folder = Folder.find_by_id(1)
    @picture.folder = current_folder
    if @picture.save
      File.open(@picture.temp_file.file.file) do |io|
        if current_folder
          parent_folder_gd_id = current_folder.gd_fid
        else
          parent_folder_gd_id = nil
        end
        file_id = upload_file(user, @picture.url_key, io, @picture.content_type, parent_folder_gd_id)
        @picture.gd_id = file_id
        @picture.save
      end
      File.unlink @picture.temp_file.file.file
      flash[:success] = "Picture added!"
      redirect_to pictures_path
    else
      @feed_items = []
      flash[:error] = "Picture not added!"
      redirect_to pictures_path
    end
  end

  def destroy
    remove_file current_user,  @picture.gd_id
    @picture.destroy
    flash[:success] = "Picture deleted"
    redirect_to request.referrer || root_url
  end

  private
    def picture_params
      params.require(:picture).permit(:temp_file)
    end

    def correct_user
      @picture = current_user.pictures.find_by(id: params[:id])
      redirect_to root_url if @picture.nil?
    end
end
