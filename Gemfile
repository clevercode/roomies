source 'http://rubygems.org'

gem 'rails', "~> 3.1.0"

gem 'thin'

gem 'rdiscount', "~> 1.6.8"               # markdown filter for views
gem 'jquery-rails', "~> 1.0.13"
gem 'simple_form', "~> 1.4.2"
gem 'devise', git: "https://github.com/plataformatec/devise.git", branch: "master"
gem 'devise_invitable', '~> 0.5.4'
gem 'omniauth', "~> 0.2.6"
gem 'mongoid', "~> 2.1"
gem "bson_ext", "~> 1.3"
gem 'mongoid_rails_migrations'
gem 'actionmailer-with-request'
gem "airbrake"

group :assets do
  gem 'sass-rails', "~> 3.1.0.rc7"
  gem 'coffee-rails', "~> 3.1.0.rc7"
  gem 'uglifier'
  gem 'compass',  "0.12.alpha.0"
end

group :development do
  gem "haml", ">= 3.1.2"
  gem "haml-rails", ">= 0.3.4"
  gem "rails-footnotes", ">= 3.7"
  gem 'mongoid-rspec'
  gem 'ruby-debug19'
  gem 'mailcatcher'
end

gem "rspec-rails", ">= 2.6.1", :group => [:development, :test]

group :test do
  gem "turn"                  # pretty printed test output
  gem "database_cleaner", ">= 0.6.7"
  gem "factory_girl_rails", ">= 1.1.rc1"
  gem "launchy", ">= 0.4.0"
  gem "guard"                 # modular filesystem event monitor utility written in Ruby
  gem "spork"                 # allows to load the test environment once, speeds it up
  gem "guard-rspec"
  gem "guard-spork"
  gem "rb-fsevent"
  gem "growl"
end

group :production do 
  gem 'therubyracer-heroku', '0.8.1.pre3'
end