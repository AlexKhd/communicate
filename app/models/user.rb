class User < ApplicationRecord
  include Concerns::Roles
  extend FriendlyId
  friendly_id :name, use: :slugged

  devise :omniauthable, :omniauth_providers => [:facebook]

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  after_create :send_admin_notification
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :chatrooms, through: :messages
  has_many :pictures, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update

  has_many :identities, dependent: :destroy

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['lower(name) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      if conditions[:name].nil?
        where(conditions).first
      else
        where(name: conditions[:name]).first
      end
    end
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email_is_verified = auth.info.email && (
        auth.info.verified || auth.info.verified_email
      )
      email = auth.info.email # if email_is_verified
      user = User.where(email: email).first if email

      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0, 20]
          # avatar_file_name: auth.info.image,
          # avatar_updated_at: Time.now,
          # facebook_name: auth.extra.raw_info.name
        )
        user.skip_confirmation!
        user.save!
        user
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    email && email !~ TEMP_EMAIL_REGEX
  end

  def facebook_uid
    identity = Identity.where(id: 1)
    identity.uid
  end

  def set_admin
    update_attribute(:role, :admin)
  end

  def send_admin_notification
    # UserMailer.welcome_email(self).deliver_later
  end

  def feed
    Picture.where("user_id = ?", id)
  end
end
