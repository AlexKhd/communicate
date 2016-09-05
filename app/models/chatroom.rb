class Chatroom < ApplicationRecord
  validates :name, presence: true, uniqueness: true, case_sensitive: false, length: { in: 6..20 }
  before_validation :sanitize, :slugify
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages

  def to_param
    self.slug
  end

  def slugify
    self.slug = self.name.downcase.gsub(' ', '-')
  end

  def sanitize
    self.name = self.name.strip
  end
end
