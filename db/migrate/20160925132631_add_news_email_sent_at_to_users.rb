class AddNewsEmailSentAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :news_email_sent_at, :datetime
  end
end
