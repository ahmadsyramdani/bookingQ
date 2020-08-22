source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'
gem 'rails', '~> 5.2.4', '>= 5.2.4.3'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'devise_token_auth', :git => 'https://github.com/lynndylanhurley/devise_token_auth.git'
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'kaminari'
gem 'phonelib'

group :development, :test do
  gem 'pry'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
end

group :test do
  gem 'simplecov'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
