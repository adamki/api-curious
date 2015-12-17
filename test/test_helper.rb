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

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      uid: "3198489685",
      provider: 'twitter',
      info: {
        description: 'bob rules',
        image: 'http://pbs.twimg.com/profile_images/599783079217995777/T4tmMdpB_normal.jpg',
        location: 'Denver, CO',
      },
      extra: {
        raw_info: {
          user_id: '1234',
          name: 'bob',
          screen_name: 'adamkijensen',
          profile_background_image_url: 'http://abs.twimg.com/images/themes/theme1/bg.png',
        }
      },
      credentials: {
        token: ENV["test_token"], 
        secret: ENV["test_secret"] 
      }
    })
  end

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
    config.default_cassette_options = {:serialize_with => :json}
    config.before_record do |r|
      r.request.headers.delete("Authorization")
    end
  end
end
