source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Core
ruby '2.6.5'
gem 'rails', '~> 5.2.4'
# Middleware
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
# css/js
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# Password
gem 'bcrypt'
# Internationalization
gem 'enum_help'
# pagination
gem 'kaminari'

gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Debug
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  # Test
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails'
  gem 'launchy', '~> 2.4', '>= 2.4.3'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
