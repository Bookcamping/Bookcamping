require 'bcrypt'

module Identifiable
  extend ActiveSupport::Concern

  included do
    attr_reader :password

    validates :password, presence: true, on: :create, if: :password_required?
    validates_presence_of :password_confirmation, on: :create, if: :password_required?
    validates_confirmation_of :password
  end

  module ClassMethods
    def authenticate(email, password)
      find_by_email(email).try(:authenticate, password)
    end

    def find_by_provider_and_uid(provider, uid)
      column = "uid_#{provider}"
      self.where(column => uid).first
    end
  end

  def password_required?
    uid_twitter.blank? and uid_google.blank? and uid_facebook.blank?
  end

  def authenticate(unencrypted_password)
    if password_digest.present? and BCrypt::Password.new(password_digest) == unencrypted_password
      self
    else
      false
    end
  end

  # Encrypts the password into the password_digest attribute.
  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.blank?
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def generate_recovery_code
    code = Digest::MD5.hexdigest("#{Random.rand(100)}#{self.id}#{Time.now}")
    update_attribute(:recovery_code, code)
  end

  def destroy_recovery_code
    update_attribute(:recovery_code, nil)
  end

end