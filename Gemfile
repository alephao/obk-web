source 'https://rubygems.org'

ruby '~> 2.3.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'

gem 'devise'

gem 'railties'

gem 'wdm', '>= 0.1.0' if Gem.win_platform?

gem 'omniauth', '1.3.1'
gem 'devise_token_auth' #, '0.1.42'
gem 'kaminari', '0.17.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'bcrypt-ruby', '~> 3.0.1', platforms: [:mingw, :mswin, :x64_mingw]

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'active_model_serializers', '~> 0.10.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'dotenv-rails', '2.1.1'
  gem 'rubocop', '0.42.0', require: false
  gem 'bullet', '5.4.0'
  gem 'rspec-rails', '3.5.2'
  gem 'factory_girl_rails', '4.7.0'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov', '0.12.0', :require => false
  gem 'database_cleaner', '1.5.3'
  gem 'ffaker', '2.2.0'
  gem 'shoulda-matchers', '3.1.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
