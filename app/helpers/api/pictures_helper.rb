module Api::PicturesHelper
  def connect_to_storage
    @drive_session ||= GoogleDrive.saved_session(config_path)
    @drive ||= @drive_session.drive
    @root_id ||= get_root
  end

  def upload_file(user, name, io, content_type, parent_folder_gd_id)
    create_user_folder(user) if user.gd_fid.nil?
    parent_folder_gd_id ||= user.gd_fid
    metadata = {
      name: name,
      title: name,
      convert: false,
      parents: [parent_folder_gd_id]
    }
    file = @drive.create_file(
            metadata,
            fields: 'id',
            upload_source: io,
            content_type: 'image/jpeg')
    file.id
  end

  def download_file(file_id, io)
    @drive.get_file(file_id, download_dest: io)
  end

  def remove_file(user, file_id)
    picture = Picture.find_by(gd_id: file_id)
    @drive.update_file(file_id, remove_parents: picture.folder.gd_fid, fields: '')
    @drive.update_file(picture.gd_id_thumb, remove_parents: picture.folder.gd_fid, fields: '') if picture.gd_id_thumb
    @drive.update_file(picture.gd_id_medium, remove_parents: picture.folder.gd_fid, fields: '') if picture.gd_id_medium
    @drive.update_file(picture.gd_id_large, remove_parents: picture.folder.gd_fid, fields: '') if picture.gd_id_large
  end

  def request_user(json = nil)
    if json.nil?
      json = JSON.parse(request.body.read)
    end
    token = json["token"]
    user = User.find_by(api_token: token)
    user.nil?? nil : user
  end

  def last_posted_folder
    if current_user.pictures.exists?
      current_user ? current_user.pictures.order('id').last.folder_id : 1
    else
      1
    end
  end

  private
    def config_path
      File.join(Rails.root, "config", "google_drive.json").to_s
    end

    def create_user_folder(user)
      if user.gd_fid.nil?
        metadata = {
          name: user.id.to_s,
          parents:[@root_id],
          mime_type: 'application/vnd.google-apps.folder'
        }
        file = @drive.create_file(metadata, fields: 'id')
        user.gd_fid = file.id
        user.save!
      end
    end

    def create_user_public_folder(user, foldername)
      if !Folder.exists?(user_id: user.id, name: foldername)
        metadata = {
          name: foldername,
          parents:[user.gd_fid],
          mime_type: 'application/vnd.google-apps.folder'
        }
        file = @drive.create_file(metadata, fields: 'id')
        folder = user.folders.build(name: foldername, gd_fid: file.id, gd_name: foldername)
        folder.save
      end
    end

    def create_new_user_folder(user, foldername)
      if !Folder.exists?(user_id: user.id, name: foldername)
        metadata = {
          name: foldername,
          parents:[user.gd_fid],
          mime_type: 'application/vnd.google-apps.folder'
        }
        file = @drive.create_file(metadata, fields: 'id')
        folder = user.folders.build(name: foldername, gd_fid: file.id, gd_name: foldername)
        folder.save
      end
    end

    def get_root
      name = Communicate::Application::config.storage_folder
      id = nil
      response = @drive.list_files(q: "mimeType='application/vnd.google-apps.folder' and name = '#{name}'",
                                   spaces: 'drive',
                                   fields:'files(id)',
                                   page_token: nil)
      for file in response.files
        id = file.id
      end
      id
    end
end
