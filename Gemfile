source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'inherited_resources'

gem 'mysql2'
gem "bigdecimal"

gem "unicorn"
gem 'foreman'
gem 'foreman-export-initscript', :git => 'git://github.com/Draiken/foreman-export-initscript.git'

gem 'jquery-rails'

# authentication and authorization
gem 'authlogic', "~> 3.2.0"
gem 'cancan'

# Search
gem "tire", :git => "git://github.com/karmi/tire.git"
gem "will_paginate", "~> 3.0"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass'
  gem "font-awesome-rails"

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'haml-rails'
end

group :test, :development do
  gem 'jasmine-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'shoulda'
  gem 'politburo', :git => 'git://github.com/redbeard/politburo.git'
  gem 'pry'
  gem 'aws-sdk'
end

# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano-s3-copy', :git => 'git://github.com/srbartlett/capistrano-s3-copy.git', :require => false
gem 'dotenv'
gem 'elbow', :require => false

