class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :file_name
      t.string :content_type
      t.string :url_key
      t.string :temp_file
      t.references :user, index: true, foreign_key: true
      t.string :gd_id

      t.timestamps null: false
    end
    add_index :pictures, [:user_id, :created_at]
  end
end
