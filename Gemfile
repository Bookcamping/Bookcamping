source 'http://rubygems.org'

gem 'rails', '3.1.2'
group :assets do
  gem 'sass-rails', '~> 3.1.5.rc.2'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
#gem 'mercury-rails', git: 'https://github.com/jejacks0n/mercury.git', ref: '4e4b9922705a3f9ccba432612d501f3b9dde1f53'

gem 'decent_exposure'
gem 'simple_form'

gem 'cancan'
gem 'bcrypt-ruby', '~> 3.0.0'
#gem 'meta_where'

gem "omniauth", ">= 1.0.0"
gem "omniauth-twitter"
gem "omniauth-openid"
gem "omniauth-facebook"

gem 'ancestry'
gem 'paper_trail'
gem 'acts_as_list'
#gem 'acts-as-taggable-on'

gem 'redcarpet'
gem 'kaminari'

gem 'fog'
gem 'carrierwave'
gem 'rmagick'

gem 'resque', :require => 'resque/server'

#gem 'prawn'
#gem 'prawnto'
#gem 'nokogiri'

unless defined?(JRUBY_VERSION)
  gem 'newrelic_rpm'
  gem 'hoptoad_notifier'
end

#if defined?(JRUBY_VERSION)
#  gem 'jdbc-mysql'
#else
  gem 'mysql2', group: [:development, :production]
#end

# heroku
#  gem 'pg'
gem 'unicorn', group: [:development, :production]

group :development do
  gem "thin"
  gem 'sqlite3'
 #gem 'mongrel', '1.2.0.pre2'
end
gem "bullet", :group => "development"

gem "rspec-rails", ">= 2.6.1", group: [:development, :test]
group :test do
#  gem 'ruby-debug19'
  gem 'database_cleaner'
  gem 'turn', :require => false
  gem 'yaml_db'
  gem "spork", "> 0.9.0.rc"
  gem "guard-spork"
  gem "guard-cucumber"
  gem "cucumber-rails", ">= 1.0.2"
  gem "factory_girl_rails", ">= 1.1.0"
  gem "capybara", ">= 1.0.1"
  # gem 'mailcatcher'
end



