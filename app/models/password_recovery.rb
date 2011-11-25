class PasswordRecovery
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email
  attr_accessor :user, :id, :persisted
  validates :email, presence: true

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
        self.id = 'enviada'
        PasswordMailer.recovery_password(identity.id).deliver
      else
        self.id = 'no-encontrada'
      end
    end
    self.persisted?
  end

  def persisted?
    persisted 
  end
end


