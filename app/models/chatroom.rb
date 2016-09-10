class Chatroom < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, uniqueness: true, case_sensitive: false, length: { in: 6..25 }
  before_validation :sanitize
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages

  def sanitize
    self.name = self.name.strip
  end
end
