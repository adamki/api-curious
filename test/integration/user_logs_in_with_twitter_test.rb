require "test_helper"

class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = OauthWorkshop::Application
    stub_omniauth
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      extra: {
        raw_info: {
          user_id: "1234",
          name: "Horace",
          screen_name: "worace",
        }
      },
      credentials: {
        token: "pizza",
        secret: "secretpizza"
      }
    })
  end

  test "logging in" do
    visit "/"
    assert_equal 200, page.status_code
    click_link "Login with Twitter"
    assert_equal "/", current_path
    assert page.has_content?("worace")
    assert page.has_link?("Sign Out")
  end
end
