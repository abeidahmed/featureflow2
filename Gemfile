source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

gem "active_link_to", "~> 1.0", ">= 1.0.5"
gem "acts_as_list", "~> 1.0", ">= 1.0.4"
gem "acts_as_tenant", "~> 0.5.0"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.4", require: false
gem "counter_culture", "~> 2.8"
gem "jbuilder", "~> 2.7"
gem "pay", "~> 2.7.1"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "pundit", "~> 2.1"
gem "rails", "~> 6.1.3", ">= 6.1.3.2"
gem "redis", "~> 4.0"
gem "sass-rails", ">= 6"
gem "sidekiq", "~> 6.2", ">= 6.2.1"
gem "sinatra", require: false
gem "stripe", "< 6.0", ">= 2.8"
gem "turbo-rails", "~> 0.5.12"
gem "view_component", require: "view_component/engine"
gem "webpacker", "~> 5.0"

# Markdown deps
gem "commonmarker", "~> 0.16"
gem "html-pipeline", "~> 2.14"
gem "sanitize", "~> 4.6"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "capybara", "~> 3.35", ">= 3.35.3"
  gem "dotenv-rails", "~> 2.7", ">= 2.7.6"
  gem "factory_bot_rails", "~> 6.2"
  gem "faker", "~> 2.18"
  gem "pundit-matchers", "~> 1.6"
  gem "rails-controller-testing", "~> 1.0", ">= 1.0.5"
  gem "rspec-rails", "~> 5.0", ">= 5.0.1"
  gem "shoulda-matchers", "~> 4.5", ">= 4.5.1"
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "rubocop", "~> 1.15"
  gem "rubocop-rails", "~> 2.10", ">= 2.10.1"
  gem "rubocop-rspec", "~> 2.3"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "timecop", "~> 0.9.4"
  gem "vcr", "~> 6.0"
  gem "webmock", "~> 3.13"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
