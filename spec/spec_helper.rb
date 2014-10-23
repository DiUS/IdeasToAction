require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'simplecov'

SimpleCov.start do
  add_filter 'app/admin'
  add_filter 'app/assets'
  add_filter 'config'
  add_filter 'coverage'
  add_filter 'db'
  add_filter 'design'
  add_filter 'doc'
  add_filter 'lib'
  add_filter 'log'
  add_filter 'mobile'
  add_filter 'provisioning'
  add_filter 'public'
  add_filter 'script'
  add_filter 'spec'
  add_filter 'vendor'

  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Models', 'app/models'
  add_group 'Views', 'app/views'
  # add_group 'Library', 'lib/my_lib'
end if ENV['COVERAGE']

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'authlogic/test_case'
require 'database_cleaner'

include Authlogic::TestCase

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
	end

  config.include JsonSpec::Helpers
end
