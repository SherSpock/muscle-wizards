source 'https://rubygems.org'

gem 'rails',                '5.1'     # App framework
gem 'pg',                   '0.21.0'  # Database for Active Record
gem 'puma',                 '3.9.1'   # App server
gem 'sass-rails',           '5.0.6'   # Stylesheets
gem 'uglifier',             '3.2.0'   # Compressor for JavaScript assets
gem 'foundation-rails',     '6.2.4.0' # Front-end framework
gem 'kaminari',             '1.0.0'   # Pagination
gem 'simple_form',          '3.5.0'   # Forms
gem 'faker',                '1.8.4'   # Fake data
gem 'figaro',               '1.1.1'   # ENV variable management
gem 'paperclip',            '5.2.0'   # File uploads
gem 'aws-sdk-s3',           '1.0.0'   # Image storage
gem 'cancancan',            '1.17.0'  # Authorization
gem 'rolify',               '5.1.0'   # Roles
gem 'devise',               '4.3.0'   # Authentication
gem 'magnific-popup-rails', '1.1.0'   # Lightbox
gem 'chartkick',            '2.2.3'   # Highcharts but worse
gem 'jquery-rails',         '4.3.1'   # May not be needed on account of ujs
gem 'jquery-ui-rails',      '5.0.5'   # For Datepicker

group :development do
  gem 'web-console', '3.5.0'           # are we using this?
  gem 'listen',      '3.0.8'           # what this for
  gem 'spring',      '2.0.2'           # Application preloading
  gem 'spring-watcher-listen', '2.0.1' # Spring-watcher is watching you
end

group :development, :test do
  gem 'factory_girl_rails', '4.8.0'                     # Data factories for testing
  gem 'database_cleaner',   '1.6.1'                     # Pristine db for testing
  gem 'capybara',           '2.13.0'                    # UI testing
  gem 'rspec-rails',        '3.6.0'                     # Testing framework
  gem 'better_errors',      '2.2.0'                     # Sweet error pages with console on blow-up
  gem 'binding_of_caller',  '0.7.3'                     # Trace bindings on up the stack
  gem 'simplecov',          '0.14.1', :require => false # Test coverage reporting
end

group :production do
  gem 'rails_12factor', '0.0.3' # 12factor config
end  



# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
