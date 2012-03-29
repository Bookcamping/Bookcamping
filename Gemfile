source 'http://rubygems.org'

gem 'rails', '3.2.0'


group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'decent_exposure'
gem 'simple_form'
gem 'friendly_id'

gem 'cancan'
gem 'bcrypt-ruby', '~> 3.0.0'

gem "omniauth", ">= 1.0.0"
gem "omniauth-twitter"
gem "omniauth-openid"
gem "omniauth-facebook"

gem 'ancestry'
gem 'paper_trail'
gem 'acts_as_list'
gem 'squeel'

gem 'redcarpet'
gem 'kaminari'

gem 'fog'
gem 'carrierwave'
gem 'rmagick'

#gem 'prawn'
#gem 'prawnto'
#gem 'nokogiri'

unless defined?(JRUBY_VERSION)
  gem 'newrelic_rpm'
  gem 'hoptoad_notifier'
end

if defined?(JRUBY_VERSION)
  gem 'jdbc-mysql'
else
  gem 'mysql2', group: [:development, :production]
end

gem 'unicorn', group: [:development, :production]

gem 'capistrano'

group :test do
  gem 'minitest'
  gem 'capybara'
  gem 'turn'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'sqlite3'
end

