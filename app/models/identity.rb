require 'bcrypt'

class Identity < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :provider, presence: true
  validates :uid, presence: true

  def bookcamping?
    provider == 'bookcamping'
  end

  def authorized?(unencrypted_password)
    BCrypt::Password.new(password_digest) == unencrypted_password
  end

  def self.create_identity(user, unencrypted_password)
    digest = BCrypt::Password.create(unencrypted_password)
    Identity.create!(user: user, provider: 'bookcamping', uid: user.email,
                     password_digest: digest)
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
