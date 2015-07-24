source 'https://rubygems.org'

ruby '2.2.2'

gem 'autoprefixer-rails'
gem 'bourbon', '~> 4.2.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'devise'
gem 'email_validator'
gem 'flutie'
gem 'friendly_id', '~> 5.1.0'
gem 'i18n-tasks'
gem 'jquery-rails'
gem 'slim-rails'
gem 'neat', '~> 1.7.0'
gem 'normalize-rails', '~> 3.0.0'
gem 'pg'
gem 'rack-canonical-host'
gem 'rails', '~> 4.2.0'
gem 'recipient_interceptor'
gem 'refills'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'title'
gem 'uglifier'
gem 'unicorn'

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console'
end

group :development, :test do
  gem 'awesome_print'
  gem 'bundler-audit', require: false
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.3.0'
end

group :test do
  gem 'capybara-webkit', '>= 1.2.0'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  gem 'rack-timeout'
end
