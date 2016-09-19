class AddGdIdLargeToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :gd_id_large, :string
  end
end
