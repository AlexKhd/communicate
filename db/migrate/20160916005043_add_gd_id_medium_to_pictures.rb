class AddGdIdMediumToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :gd_id_medium, :string
  end
end
