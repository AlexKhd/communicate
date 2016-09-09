class User < ApplicationRecord
  include Concerns::Roles
  extend FriendlyId
  friendly_id :name, use: :slugged

  after_create :send_admin_notification
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :chatrooms, through: :messages
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def set_admin
    update_attribute(:role, :admin)
  end

  def send_admin_notification
    # UserMailer.welcome_email(self).deliver_later
  end
end
