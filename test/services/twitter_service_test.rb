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

  test "#favorite_tweet" do
    VCR.use_cassette("Twitter_Service#favorite_tweet") do
      favorite_tweets = service.favorite_tweet(677406834261549056)
      favorite_tweet = favorite_tweets.first

      assert_equal Array, favorite_tweets.class 
      assert_equal 1, favorite_tweets.count 
    end
  end

  test "#retweet" do
    VCR.use_cassette("Twitter_Service#retweet") do
      retweets = service.retweet(677380359894335488)
      retweet = retweets.first
      assert_equal Twitter::Tweet, retweet.class
    end
  end

  test "#find_tweet" do
    VCR.use_cassette("Twitter_Service#find_tweet") do
      tweet = service.find_tweet(677412314962759680)
      assert_equal Twitter::Tweet, tweet.class
      tweet_message = "@adamkijensen fsdafdas"
      assert_equal tweet_message, tweet.full_text
    end
  end

  test "#find_user_by_tweet" do
    VCR.use_cassette("Twitter_Service#find_user_by_tweet") do
      user = service.find_user_by_tweet(677412314962759680)
      assert_equal "adamkijensen", user.screen_name
    end
  end
end

