class AddGdFidToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gd_fid, :string
  end
end
