source 'https://rubygems.org'

gem 'rails', '4.1.4'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'bootstrap_form' # Bootstrap forms
gem 'turbolinks'     # Load pages using PJAX
gem 'jquery-rails'

gem 'chartkick'
gem 'groupdate'

gem 'octokit', '~> 2.0' # GitHub API

gem 'nprogress-rails' # Youtube style progress bar for turbolinks

gem 'react_on_rails', '~> 1.1.1'

# TODO: Don't use different databases in development and production
group :production do
  gem 'rails_12factor' # For Heroku
  gem 'pg'             # Use PostgresSQL on Heroku
end

group :test, :development do
  gem 'mysql2' # Use mysql as the database for Active Record
end

group :test do
  gem 'guard-rspec', require: false
  gem 'capybara'
  gem 'spork', github: 'sporkrb/spork'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'guard-spork'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 2.14.2'
  gem 'simplecov'
  gem 'database_cleaner'
end

group :development do
  gem 'better_errors',     '0.8.0' # Better rails error pages
  gem 'binding_of_caller', '0.7.0'
  gem 'awesome_print'
  gem 'quiet_assets'
  gem 'newrelic_rpm'
  gem 'bullet' # detects common SQL mistakes
  gem 'rb-fsevent', '~> 0.9.1' # Enables guard to detect file changes osx
end

gem 'bcrypt', '~> 3.1.7', require: true

gem 'unicorn'

gem 'therubyracer', platforms: :ruby, require: 'v8'
gem 'bootstrap-sass'

gem 'therubyracer', platforms: :ruby
