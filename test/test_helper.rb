ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "capybara/rails"
require "capybara/minitest"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    include Devise::Test::IntegrationHelpers
    include FactoryBot::Syntax::Methods if defined?(FactoryBot)
  end
end

class ActionDispatch::SystemTestCase
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
end
