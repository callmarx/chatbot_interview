# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.2.2"

###### BASIC FRAMEWORKS ######
# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.4"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

##### VIEWS/CONTROLLERS #####
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails", "~> 3.5.1"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails", "~> 2.0.1"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "~> 2.0.5"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "~> 1.3.3"
# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails", "~> 2.6.1"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", "~> 2.12.0"

##### ADDITIONAL FUNCTIONS #####
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
# Library that allows you to use other API’s and provides responses from them.
gem "httparty", "~> 0.22.0"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# This 'if' may seem redundant but for some reason it is necessary to suppress
# a warning on non (Windows or JRuby) platforms.
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby] if %w[mingw mswin x64_mingw jruby].include?(RUBY_PLATFORM)

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows]
  # Shim to load environment variables from .env into ENV in development.
  gem "dotenv", "~> 3.1.2"
  # Show database columns and indexes inside files.
  gem "annotate", "~> 3.2"
  # Ensure the database is in a clean state on every test.
  gem "database_cleaner-active_record", "~> 2.1"
  # Generate fake data for use in tests.
  gem "faker", "~> 3.4.1"
  # Generate models based on factory definitions.
  gem "factory_bot_rails", "~> 6.4.3"
  ### TO-DO: In addition to the foreman gem, create a bin/setup script to prepare
  ### the project for first use. Use as reference:
  ### https://github.com/rubyforgood/human-essentials/blob/main/bin/setup
  # Rails plugin for command line.
  gem "pry-rails", "~> 0.3.9"
  # RSpec behavioral testing framework for Rails.
  gem "rspec-rails", "~> 6.1.2"
  # Show code coverage.
  gem "simplecov", "~> 0.22"
  # More concise test ("should") matchers
  gem "shoulda-matchers", "~> 6.2"
  # Static analysis / linter.
  gem "rubocop", "~> 1.64.1"
  gem "rubocop-packaging", "~> 0.5.2"
  gem "rubocop-performance", "~> 1.21.0"
  gem "rubocop-rails", "~> 2.24.1"
  gem "rubocop-rspec", "~> 2.29.1"
  gem "rubycritic", "~> 4.9"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console", "~> 4.2.1"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
