class AddGdIdThumbToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :gd_id_thumb, :string
  end
end
