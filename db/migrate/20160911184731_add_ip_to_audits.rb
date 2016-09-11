class AddIpToAudits < ActiveRecord::Migration[5.0]
  def change
    add_index :audits, :ip
  end
end
