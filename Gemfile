# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 7.0"

gem "nokogiri", ">= 1.15.2"
gem "pg", ">= 1.5.3"
gem "puma", ">= 6.3.0"
gem "uglifier", ">= 4.2.0"
gem "jbuilder", ">= 2.11.5"
gem "sass-rails", ">= 6.0.0"

group :development do
  gem "listen", ">= 3.0.8", "< 3.2"
  gem "web-console", ">= 4.2.0"
end

group :rubocop do
  gem "rubocop", ">= 1.51.0", require: false
  gem "rubocop-minitest", require: false
  gem "rubocop-packaging", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "devise", "~> 4.9.2"
gem "friendly_id", ">= 5.5.0"
gem "geocoder", ">= 1.8.1"
gem "kaminari", ">= 1.2.2"
gem "country_select", ">= 8.0.1"
gem "image_processing", ">= 1.2"
gem "bootstrap-icons-helper", ">= 1.0.13"
gem "recaptcha", ">= 5.14.0"
gem "countries", ">= 5.4.0"
gem "social-share-button", ">= 1.2.4"
