class TwitterService
  attr_reader :client

  def initialize(user)
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["consumer_key"]
      config.consumer_secret     = ENV["consumer_secret"]
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def timeline
    client.home_timeline
  end

  def new_tweet(tweet)
    client.update(tweet)
  end

  def followers_count
    client.user.followers_count
  end

  def following_count
    client.user.friends_count
  end

  def total_tweets
    client.user.tweets_count
  end

  def banner_image
    client.user.profile_banner_uri_https(size = :web).to_s
  end

  def favorite_tweet(id)
    client.favorite(id)
  end

  def retweet(id)
    client.retweet(id)
  end

  def reply(id, tweet_message)
    tweet = find_tweet(id)
    screen_name = find_user_by_tweet(tweet.id).screen_name
    client.update("@#{screen_name} #{tweet_message}")
  end

  def find_tweet(id)
    client.status(id)
  end

  def find_user_by_tweet(id)
    client.status(id).user
  end
  
end
