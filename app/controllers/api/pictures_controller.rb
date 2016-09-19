class Api::PicturesController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :connect

  def create
    json = JSON.parse(request.body.read)
    user = request_user(json)
    if user.nil?
      render :json => {error: "No file uploaded."}
    else
      content_type = json["type"]
      picture = user.pictures.create(file_name: json["name"],
                                      content_type: content_type)
      if picture.save
        file_id = upload_file(user, picture.url_key, StringIO.new(Base64.decode64(json["data"])), content_type)
        picture.gd_id = file_id
        picture.save
        access_path = request.base_url + (api_picture_path id: picture.url_key)
        render :json => {url: "#{access_path}"}
      else
        render :json => {error: "Failed to save."}
      end
    end
  end

  def show
    key = params[:id]
    picture = Picture.find_by(url_key: key)
    if picture.nil?
      render :json => {error: "File not found."}
    else
      case params[:size]
        when 'thumb'
          google_file_id = picture.gd_id_thumb
        when 'medium'
          google_file_id = picture.gd_id_medium
        when 'large'
          google_file_id = picture.gd_id_large
        else
          google_file_id = picture.gd_id
      end
      sio = StringIO.new
      download_file(google_file_id, sio)
      sio.rewind
      send_data sio.read, filename: picture.file_name, type: picture.content_type
    end
  end

  def destroy
    json = JSON.parse(request.body.read)
    user = request_user(json)
    if user.nil?
      render :json => {error: "No file deleted."}
    else
      key = params[:id]
      picture = Picture.find_by(url_key: key)
      remove_file(user, picture.gd_id)
      render :json => {id: "#{key}"}
    end
  end
end
