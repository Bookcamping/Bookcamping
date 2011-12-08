# encoding: utf-8
#
# User::Identities
#
# Extensiones a User para manejar identidades
module Users::Identities
  def identify_with(password)
    id = identities.where(provider: 'bookcamping').first
    id ||= identities.build(provider: 'bookcamping', uid: email) 
    id.password = password
    id.save
    identities(true)
  end

  # Genera una identidad (Identity) para este usuario
  # En ningún momento un usuario debería tener más de una identidad 'recovery'
  def generate_recovery_identity
    id = identities.where(provider: 'recovery').first
    id ||= identities.build(provider: 'recovery')
    id.uid = Digest::MD5.hexdigest("#{Random.rand(100)}#{self.id}#{Time.now}")
    id.save!
    identities(true)
    id
  end

  # Borra la identidad de recuperación (Identity provider: recovery)
  def destroy_recovery_identity
    identities.where(provider: 'recovery').destroy_all
  end
end

