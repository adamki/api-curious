ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require "capybara/rails"
require "mocha/mini_test"
require "pry"

SimpleCov.start "rails"

class ActiveSupport::TestCase
  include Capybara::DSL
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
    config.default_cassette_options = {:serialize_with => :json}
    config.before_record do |r|
      r.request.headers.delete("Authorization")
    end
  end
end
