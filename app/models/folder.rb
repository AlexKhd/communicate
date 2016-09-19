class Folder < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :user
  validates :name, presence: true, length: { in: 6..25 }
  validates :gd_name, presence: true, uniqueness: true
  validates :user_id, presence: true
  has_many :pictures, dependent: :destroy
end
