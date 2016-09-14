class CreateFolders < ActiveRecord::Migration[5.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.string :gd_name
      t.string :gd_fid
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
