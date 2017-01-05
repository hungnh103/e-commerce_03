source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.1"
gem "sqlite3"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "devise", "~> 4.2"
gem "cancancan", "~> 1.15"
gem "bootstrap-sass", "~> 3.3", ">= 3.3.7"
gem "jquery-turbolinks", "~> 2.1"
gem "i18n", "~> 0.7.0"
gem "i18n-js", "~> 2.1", ">= 2.1.2"
gem "font-awesome-rails"
gem "config"
gem "will_paginate"
gem "bcrypt", "~> 3.1", ">= 3.1.11"
gem "faker", "~> 1.6", ">= 1.6.6"
gem "carrierwave", "~> 0.11.2"
gem "mini_magick", "~> 4.6"
gem "awesome_print", "1.7.0"

group :development, :test do
  gem "rubocop", require: false
  gem "byebug", platform: :mri
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
