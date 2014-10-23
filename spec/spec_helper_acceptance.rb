ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'capybara/rails'
require 'capybara/rspec'
require 'authlogic/test_case'
require 'rack_session_access/capybara'
require 'webmock/rspec'
require 'database_cleaner'
require 'capybara/poltergeist'

include Authlogic::TestCase

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Capybara configuration
Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
	config.use_transactional_fixtures = true
	config.infer_base_class_for_anonymous_controllers = false
	config.order = 'random'

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
