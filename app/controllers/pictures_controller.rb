class PicturesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :connect, only: [:create, :destroy]
  before_action :redirect_users, except: :index

  def index
    @feed_all_items_from_public = Picture.includes(:folder).where("folders.name" => "MyPublicFolder").paginate(page: params[:page], per_page: 10)
    @folders = Folder.all
    if logged_in?
      connect
      @picture = current_user.pictures.build
      #@feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
      #@feed_all_items = Picture.all.paginate(page: params[:page], per_page: 10)
      #@feed_all_items = Folder.where(name: :MyPublicFolder).pictures #.all.paginate(page: params[:page], per_page: 10)

      # create_user_folder(current_user) if current_user.gd_fid.nil?
      # create_user_public_folder(current_user, 'MyPublicFolder') if !Folder.exists?(user_id: current_user.id, name: 'MyPublicFolder')
    end
  end

  def create
    user = current_user
    @picture = Picture.new(picture_params)
    @picture.set_attributes
    if params[:new_folder_name] == ''
      current_folder = Folder.friendly.find_by(id: params[:picture][:folder_id])
    else
      create_new_user_folder(current_user, params[:new_folder_name])
      current_folder = Folder.friendly.find_by(name: params[:new_folder_name])
      @picture.folder = current_folder
    end
    if @picture.save
      File.open(@picture.temp_file.file.file) do |io|
        parent_folder_gd_id = current_folder.gd_fid
        file_id = upload_file(user, @picture.url_key, io, @picture.content_type, parent_folder_gd_id)
        @picture.gd_id = file_id
        @picture.save
      end
      File.open(@picture.temp_file.versions[:thumb].file.file) do |io|
        parent_folder_gd_id = current_folder.gd_fid
        file_id = upload_file(user, @picture.url_key + '_thumb', io, @picture.content_type, parent_folder_gd_id)
        @picture.gd_id_thumb = file_id
        @picture.save
      end
      File.open(@picture.temp_file.versions[:medium].file.file) do |io|
        parent_folder_gd_id = current_folder.gd_fid
        file_id = upload_file(user, @picture.url_key + '_medium', io, @picture.content_type, parent_folder_gd_id)
        @picture.gd_id_medium = file_id
        @picture.save
      end
      File.open(@picture.temp_file.versions[:large].file.file) do |io|
        parent_folder_gd_id = current_folder.gd_fid
        file_id = upload_file(user, @picture.url_key + '_large', io, @picture.content_type, parent_folder_gd_id)
        @picture.gd_id_large = file_id
        @picture.save
      end
      File.unlink @picture.temp_file.file.file
      File.unlink @picture.temp_file.versions[:thumb].file.file
      File.unlink @picture.temp_file.versions[:medium].file.file
      File.unlink @picture.temp_file.versions[:large].file.file
      flash[:success] = "Picture #{@picture.file_name} added!"
      redirect_to pictures_path
    else
      @feed_items = []
      flash[:error] = 'Picture not added!'
      redirect_to pictures_path
    end
  end

  def destroy
    remove_file current_user, @picture.gd_id
    @picture.destroy
    flash[:success] = "Picture deleted"
    redirect_to request.referrer || root_url
  end

  private
    def picture_params
      params.require(:picture).permit(:temp_file, :folder_id)
    end

    def correct_user
      @picture = current_user.pictures.find_by(id: params[:id])
      redirect_to root_url if @picture.nil?
    end
end
