source 'https://rubygems.org'

gem 'bundler'
gem 'rake'
gem 'hanami',       '~> 0.9'
gem 'hanami-model', '~> 0.7'

gem 'pg'
gem 'sidekiq'
gem 'sinatra', '~> 1.4.6', require: false
gem 'dry-auto_inject'
gem 'dry-monads'


group :development do
  gem 'shotgun'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'rspec'
  gem 'capybara'
end

group :production do
#  gem 'puma'
end
