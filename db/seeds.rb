# encoding: utf-8
# Prepara la base de datos para una nueva instalación
# Utiliza datos de prueba si quieres montar un servidor de desarrollo en local
#

def create_bookcamping
  Camp.create!(name: 'bookcamping')
end

def create_licenses
  License.create(:name => 'No lo se', :url => '', :icon => '', :open => false)

  License.create(:name => 'Creative commons CC BY-NC-ND (Reconocimiento/NoComercial/SinObraDerivada',
                 :url => 'http://creativecommons.org/licenses/by-nc-nd/3.0',
                 :icon => 'http://upload.wikimedia.org/wikipedia/commons/0/03/CC-BY-NC-ND-icon-80x15.png',
                 :open => true)

  License.create(:name => 'Creative commons CC BY-NC-SA (Reconocimiento/NoComercial/CompartirIgual)',
                 :url => 'http://creativecommons.org/licenses/by-nc-sa/3.0',
                 :icon => 'http://upload.wikimedia.org/wikipedia/commons/1/1f/CC-BY-NC-SA-icon-80x15.png',
                 :open => true)

  License.create(:name => 'Creative commons CC BY-NC (Reconocimiento/NoComercial)',
                 :url => 'http://creativecommons.org/licenses/by-nc/3.0',
                 :icon => 'http://upload.wikimedia.org/wikipedia/commons/b/bc/CC-BY-NC-icon-80x15.png',
                 :open => true)

  License.create(:name => 'Creative commons CC BY-ND (Reconocimiento/SinObraDerivada)',
                 :url => 'http://creativecommons.org/licenses/by-nd/3.0',
                 :icon => 'http://upload.wikimedia.org/wikipedia/commons/8/8e/CC-BY-ND-icon-80x15.png',
                 :open => true)

  License.create(:name => 'Creative commons CC BY-SA (Reconocimiento/CompartirIgual)',
                 :url => 'http://creativecommons.org/licenses/by-sa/3.0',
                 :icon => 'http://upload.wikimedia.org/wikipedia/commons/9/96/CC-BY-SA-icon-80x15.png',
                 :open => true)

  License.create(:name => 'Creative commons CC BY (Reconocimiento)',
                 :url => 'http://creativecommons.org/licenses/by/3.0',
                 :icon => 'http://upload.wikimedia.org/wikipedia/commons/b/b1/CC-BY-icon-80x15.png',
                 :open => true)

  License.create(:name => 'Dominio público', :url => 'http://es.wikipedia.org/wiki/Dominio_p%C3%BAblico',
                 :icon => '/assets/pd16.png', :open => true)

  License.create(:name => 'Copyright', :url => 'http://en.wikipedia.org/wiki/Copyright',
                 :icon => '/assets/cr16.png', :open => false)
end

def create_user
  u = User.create!(name: 'bookcamping', email: 'hola@bookcamping.cc', rol: 'admin')

end

unless Rails.env.test?
  create_bookcamping if Camp.count == 0
  create_licenses if License.count == 0
  create_user if User.count == 0
end
