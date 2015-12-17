require './test/test_helper'

class TwitterServiceTest < ActiveSupport::TestCase
  attr_reader :service

  def setup
    Capybara.app = OauthWorkshop::Application
    stub_omniauth
    @service = TwitterService.new(users(:one))
  end

  test "#timeline" do
    VCR.use_cassette("Twitter_Service#timeline") do
      assert_equal 2, service.timeline.count
    end
  end

  test "#followers_count" do
    VCR.use_cassette("Twitter_Service#followers_count") do
      assert_equal 11, service.followers_count
    end
  end

  test "#new_tweet" do
    VCR.use_cassette("Twitter_Service#new_tweet") do
      tweet = service.new_tweet("SHEEEEIIIIT")
      assert_equal Twitter::Tweet, tweet.class    
      assert_equal "SHEEEEIIIIT", tweet.text    
    end
  end

  test "#following_count" do
    VCR.use_cassette("Twitter_Service#following_count") do
      assert_equal 0, service.following_count
    end
  end

  test "#total_tweets" do
    VCR.use_cassette("Twitter_Service#total_tweets") do
      assert_equal 6, service.total_tweets
    end
  end

  test "#banner_image" do
    VCR.use_cassette("Twitter_Service#banner_image") do
      url = "https://pbs.twimg.com/profile_banners/3198489685/1431834403/web"
      assert_equal url, service.banner_image
    end
  end
end

