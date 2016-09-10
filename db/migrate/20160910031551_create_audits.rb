class CreateAudits < ActiveRecord::Migration[5.0]
  def change
    create_table :audits do |t|
      t.string :ip
      t.string :user_agent
      t.string :url
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
