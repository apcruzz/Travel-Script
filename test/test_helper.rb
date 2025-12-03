ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

require "factory_bot_rails"

require "minitest/spec"

require "capybara/rails"

require "minitest/reporters"

Dir[File.join(__dir__, "helpers", "*.rb")].each { |file| require file}

Minitest::Reporters.use!(Minitest::Reporters::ProgressReporter.new(color: true), ENV, Minitest.backtrace_filter)

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    # fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

class ActionDispatch::InterhrationTest
  include Capybara::DSL
  include TextHelpers
end
