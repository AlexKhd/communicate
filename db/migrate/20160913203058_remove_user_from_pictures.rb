class RemoveUserFromPictures < ActiveRecord::Migration[5.0]
  def change
    remove_index :pictures, name: "index_pictures_on_user_id_and_created_at"
    remove_reference :pictures, :user, foreign_key: true
  end
end
