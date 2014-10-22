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

ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'capybara/rails'
require 'capybara/rspec'
require "authlogic/test_case"
require "rack_session_access/capybara"
require 'webmock/rspec'
require 'database_cleaner'
require 'capybara/poltergeist'

include Authlogic::TestCase

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Capybara configuration
Capybara.javascript_driver = :poltergeist

WebMock.disable_net_connect! allow: 'codeclimate.com'

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each do
    bitly_response = {}
    bitly_response["status_code"] = 200
    bitly_response["status_txt"] = "OK"
    bitly_response["data"] = {"long_url" => "http:\/\/54.79.124.80\/ideas\/17", "url" => "http:\/\/bit.ly\/14zIYbx", "hash" => "14zIYbx", "global_hash" => "14zIYby", "new_hash" => 0}
    stub_request(:any, /.*api\.bit\.ly*/).to_return(:status => 200, :body => bitly_response.to_json, :headers => {"content-type" => "application/json"})
	end

  config.include JsonSpec::Helpers
  config.include LoginMacros
end
