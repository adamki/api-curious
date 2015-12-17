require "test_helper"

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = OauthWorkshop::Application
    stub_omniauth
  end

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

  test "logging in" do
    VCR.use_cassette("dashboard#show") do
      visit "/"
      assert_equal 200, page.status_code
      
      click_link "Login with Twitter"

      assert_equal dashboard_path, current_path
      save_and_open_page
      assert page.has_link?("Sign Out")
      assert page.has_content?("Tweets: 5")
      assert page.has_content?("@adamkijensen")
      assert page.has_content?("Followers: 11")
      assert page.has_content?("Following: 0")
    end
  end
end
