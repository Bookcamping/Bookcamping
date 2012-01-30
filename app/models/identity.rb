require 'bcrypt'

class Identity < ActiveRecord::Base
  belongs_to :user, inverse_of: :identities

  validates :user_id, presence: true, unless: :nested
  validates :uid, presence: true, unless: :nested
  validates :provider, presence: true
  attr_accessor :nested

  def bookcamping?
    provider == 'bookcamping'
  end

  def authorized?(unencrypted_password)
    bookcamping? and BCrypt::Password.new(password_digest) == unencrypted_password
  end

  def password=(unencrypted_password)
    self.password_digest = BCrypt::Password.create(unencrypted_password)
  end

  def self.identify_omniauth(omniauth)
    Identity.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
  end

  def self.identify_credentials(email, password)
    identity = Identity.find_by_uid(email)
    if identity
      identity.authorized?(password) ? identity : nil
    end
  end

end
