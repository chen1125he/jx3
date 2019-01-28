# frozen_string_literal: true

source 'https://gems.ruby-china.com'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'

  # annotate schema info
  gem 'annotate', git: 'https://github.com/ctran/annotate_models.git'

  # rspec
  gem 'rspec-rails'

  # rubocop
  gem 'rubocop', require: false
end

# view
gem 'bootstrap', '~> 4.2.1'
gem 'font-awesome-sass'
gem 'metismenu-rails', github: 'lanvige/metismenu-rails'
gem 'slim-rails', '~> 3.1'

# ui
gem 'echarts-rails'

# Deployment
gem 'mina', '~> 1.2.2', require: false
gem 'mina-clockwork', require: false
gem 'mina-logs', '~> 1.1.0', require: false
gem 'mina-multistage', '~> 1.0.3', require: false
gem 'mina-puma', '~> 1.1.0', require: false
gem 'mina-sidekiq', '~> 1.0.3', require: false

# Background job
gem 'redis-namespace'
gem 'sidekiq', '~> 4.2'

# App configuration
gem 'figaro', '~> 1.1'

gem 'enumerize'
