# Password Recovery
#
# Es un modelo (sin backend en base de datos) que encapsula la operación de
# recuperar contraseña
# 
class PasswordRecovery
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email
  attr_accessor :user, :id, :persisted
  attr_accessor :status
  validates :email, presence: true

  STATUS = [:valid, :user_not_found]

  def initialize(attributes = {})
    if attributes
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
    persisted = false
  end 

  def save
    if valid?
      self.persisted = true
      user = User.find_by_email(email)
      if user
        identity = user.generate_recovery_identity
        self.status = 'enviada'
        PasswordMailer.recovery_password(identity.id).deliver
      else
        self.status = 'no-encontrada'
      end
    end
    self.persisted?
  end

  def persisted?
    persisted 
  end
end


