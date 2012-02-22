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
      self.user = User.find_by_email(email)
      if user
        user.generate_recovery_code
        self.status = 'enviada'
        PasswordMailer.recovery_password(user.id).deliver
        self.id = user.id
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


