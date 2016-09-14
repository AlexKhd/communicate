class RemoveUserFromFolders < ActiveRecord::Migration[5.0]
  def change
    remove_reference :folders, :user, foreign_key: true
  end
end
