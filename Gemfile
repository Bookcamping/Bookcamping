source 'http://rubygems.org'

gem 'rails', '3.1.1'

group :assets do
  gem 'sass-rails', "  ~> 3.1.4"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'ejs'
end

gem 'jquery-rails'

gem 'inherited_resources'
gem 'decent_exposure'
gem 'simple_form'
gem 'css3buttons'
gem 'rails3-jquery-autocomplete'

gem 'cancan'
#gem 'meta_where'

gem 'omniauth'

gem 'ancestry'
gem 'paper_trail'
gem 'acts_as_list'
gem 'redcarpet'
gem 'kaminari'
gem 'has_scope'
gem 'responders'

gem 'fog'
gem 'carrierwave'
gem 'rmagick'

#gem 'prawn'
#gem 'prawnto'
#gem 'nokogiri'

gem 'exception_notification', :require => 'exception_notifier'
gem 'newrelic_rpm'

# heroku
group :production do
#  gem 'pg'
end

group :test, :development do
  # Pretty printed test output
  #gem 'unicorn'
  gem "thin"
  gem 'sqlite3'
  gem 'mysql2'
  gem 'oink'
  #gem 'mongrel', '1.2.0.pre2'
  gem 'ruby-debug19'
  gem 'test-unit'
  gem 'database_cleaner'
  gem 'turn', :require => false
  gem 'yaml_db'
  gem "rspec-rails", ">= 2.6.1"
  gem "factory_girl_rails", ">= 1.1.0", :group => :test
  gem "cucumber-rails", ">= 1.0.2", :group => :test
  gem "capybara", ">= 1.0.1", :group => :test
  gem "spork", "> 0.9.0.rc"
  gem "guard-spork"
  gem "guard-cucumber"
end

