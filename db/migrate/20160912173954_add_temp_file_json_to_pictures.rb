class AddTempFileJsonToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :temp_file_json, :json
  end
end
