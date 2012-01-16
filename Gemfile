source 'http://rubygems.org'

gem 'rails', '~> 3.2.0rc2'


group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.0'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'decent_exposure'
gem 'simple_form'

gem 'cancan'
gem 'bcrypt-ruby', '~> 3.0.0'
#gem 'meta_where'

gem 'omniauth', git: 'git://github.com/intridea/omniauth.git'
#gem "omniauth", ">= 1.0.0"
gem "omniauth-twitter"
gem "omniauth-openid"
gem "omniauth-facebook"

gem 'ancestry'
gem 'paper_trail'
gem 'acts_as_list'

gem 'redcarpet'
gem 'kaminari'

gem 'fog'
gem 'carrierwave'
gem 'rmagick'

#gem 'resque', :require => 'resque/server'

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
# gem "bullet", group: "development"

gem "rspec-rails", ">= 2.8.1", group: [:development, :test]
group :test do
  gem 'ruby-debug19'
  gem 'database_cleaner'
  gem 'turn', :require => false
  gem 'yaml_db'
  gem "spork", "> 0.9.0.rc"
  gem "guard-spork"
  gem "guard-cucumber"
  gem "cucumber-rails", ">= 1.0.2"
  gem "factory_girl_rails", ">= 1.1.0"
  gem "capybara", ">= 1.0.1"
  gem "sqlite3"
end

gem 'capistrano'

