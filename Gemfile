# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", ">=7.1"

gem "nokogiri", ">= 1.16.0"
gem "pg", ">= 1.5.6"
gem "puma", ">= 6.4.2"
gem "uglifier", ">= 4.2.0"
gem "jbuilder", ">= 2.11.5"
gem "sass-rails", ">= 6.0.0"
gem "rexml", ">= 3.3.6"

group :development do
  gem "listen", ">= 3.8.0"
  gem "web-console", ">= 4.2.1"
end

group :rubocop do
  gem "rubocop", ">= 1.56.4", require: false
  gem "rubocop-minitest", require: false
  gem "rubocop-packaging", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-md", require: false
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "devise", "~> 4.9.2"
gem "friendly_id", ">= 5.5.0"
gem "geocoder", ">= 1.8.2"
gem "country_select", ">= 8.0.3"
gem "image_processing", ">= 1.2"
gem "bootstrap-icons-helper", ">= 1.0.13"
gem "recaptcha", ">= 5.15.0"
gem "countries", ">= 5.7.0"
gem "schema_dot_org"
gem "jwt", "~> 2.7"
gem "bcrypt", "~> 3.1.7"
gem "kaminari", ">= 1.2.2"
gem "rdoc", ">= 6.6.3.1"
