source 'https://rubygems.org'


gem 'rails',            '5.1'     # App framework
gem 'pg',               '0.21.0'  # Database for Active Record
gem 'puma',             '3.9.1'   # App server
gem 'sass-rails',       '5.0.6'   # Stylesheets
gem 'uglifier',         '3.2.0'   # Compressor for JavaScript assets
gem 'foundation-rails', '6.2.4.0' # Front-end framework
gem 'kaminari',         '1.0.0'   # Pagination
gem 'simple_form',      '3.5.0'   # Forms
gem 'faker',            '1.8.4'   # Fake data
gem 'figaro',           '1.1.1'   # ENV variable management
gem 'paperclip',        '5.2.0'   # File uploads
gem 'aws-sdk-s3',       '1.0.0'   # Image storage
gem 'cancancan'
gem 'rolify'
gem 'devise'
gem 'magnific-popup-rails'
gem 'chartkick'
gem 'jquery-rails', '4.3.1'
gem 'jquery-ui-rails', '5.0.5'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'rspec-rails', '~> 3.1'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'simplecov', :require => false
end

group :production do
  gem 'rails_12factor',   '0.0.3'
end  



# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
