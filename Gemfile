source 'http://rubygems.org'

gem 'rails', '~> 3.2.0'
gem 'rack', '~> 1.4.1'

# Web server
gem 'thin'

# Mongo
gem 'mongoid', "~> 2.3"
gem "bson_ext", "~> 1.4"
gem 'mongoid_rails_migrations'

# Authentication
gem 'devise', "~> 1.5.3"
gem 'omniauth', "~> 1.0.2"
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'

# Markdown
gem 'rdiscount', "~> 1.6.8"

# Other
gem 'simple_form', "~> 1.4.2"

# Exception tracking
# gem "airbrake"

# Stripe API
gem 'stripe'

# Rails extensions
gem 'jquery-rails', "~> 1.0.13"
gem 'haml-rails', "~>0.3.4"

group :development, :test do
  gem 'rspec-rails', "~> 2.8.1"
  gem 'jasmine'
  gem 'jasminerice'
end

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '~> 1.0.3'
  gem 'bourbon'
end

group :development do
  gem 'mailcatcher'
  gem 'foreman'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-spork'
  gem 'guard-jasmine'
  gem 'spork', '~> 0.9.0.rc9'
  group :mac do
    gem 'rb-fsevent'
    gem 'growl'
    gem 'ruby_gntp'
  end
  gem 'pry-rails'
end

group :test do
  gem 'capybara', '~> 1.1.2'
  gem 'capybara-webkit', '~> 0.7.2'
  gem 'shoulda-matchers'
  gem 'mongoid-rspec'
  gem "database_cleaner", ">= 0.6.7"
  gem "factory_girl_rails", "~> 1.4.0"
  gem "launchy", ">= 0.4.0"
end

