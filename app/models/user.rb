class User < ApplicationRecord
  include Concerns::Roles
  extend FriendlyId
  friendly_id :name, use: :slugged

  before_validation :normalize_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :chatrooms, through: :messages
  validates :name, presence: true, uniqueness: true
  # validates :email, presence: true, uniqueness: true

  def normalize_email
    self.email = self.name + '@dot.com' if email.blank?
  end
end
