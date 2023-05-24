# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 7.0.4.3"

gem "nokogiri", ">= 1.15.2"
gem "pg", ">= 1.5.3"
gem "puma", ">= 6.2.2"
gem "uglifier", ">= 4.2.0"
gem "jbuilder", ">= 2.11.5"
gem "sass-rails", ">= 6.0.0"

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
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
gem "friendly_id"
gem "invisible_captcha"
gem "cookies_eu", ">= 1.7.8"
gem "geocoder"
gem "kaminari"
gem "country_select"
gem "image_processing", ">= 1.2"
