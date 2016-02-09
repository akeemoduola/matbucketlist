source "https://rubygems.org"
ruby "2.2.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", github: "rails/rails"
# Use postgresql as the database for Active Record
gem "pg", "~> 0.18"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# Use Puma as the app server
gem "puma"
gem "active_model_serializers", "~> 0.10.0.rc2"
gem "jwt", "~> 1.5.1"
gem "bcrypt"
gem "figaro", "~> 1.1", ">= 1.1.1"
gem "coveralls", "~> 0.8.10", require: false
gem "rails_12factor", group: :production

group :development, :test do
  gem "pry"
  gem "pry-nav"
  gem "rspec-rails", git: "https://github.com/rspec/rspec-rails.git",
                     branch: "master"
  gem "rspec-core", git: "https://github.com/rspec/rspec-core.git",
                    branch: "master"
  gem "rspec-support", git: "https://github.com/rspec/rspec-support.git",
                       branch: "master"
  gem "rspec-expectations",
      git: "https://github.com/rspec/rspec-expectations.git", branch: "master"
  gem "rspec-mocks", git: "https://github.com/rspec/rspec-mocks.git",
                     branch: "master"
  gem "pry-rails", "~> 0.3.4"
  gem "factory_girl_rails"
  gem "faker", "~> 1.6", ">= 1.6.1"
  gem "database_cleaner"
  gem "rails_apps_testing"
  gem "codeclimate-test-reporter", "~> 0.4.8", require: nil
end

group :development do
  gem "spring"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
