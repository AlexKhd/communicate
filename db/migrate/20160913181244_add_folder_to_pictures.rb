class AddFolderToPictures < ActiveRecord::Migration[5.0]
  def change
    add_reference :pictures, :folder, foreign_key: true
  end
end
