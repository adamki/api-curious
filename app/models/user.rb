class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    user = find_or_create_by(uid: auth[:uid])
    user.update_attributes(
      uid:                auth.uid,

      oauth_token:        auth.credentials.token,
      oauth_token_secret: auth.credentials.secret,

      name:               auth.extra.raw_info.name,
      screen_name:        auth.extra.raw_info.screen_name,
      background_url:     auth.extra.raw_info.profile_background_image_url,

      description:        auth.info.description,
      image:              auth.info.image,
      location:           auth.info.location,
    )
    user
  end

  def twitter_client
    @service ||= TwitterService.new(self)
  end

  delegate :timeline,
           :new_tweet,
           :followers_count,
           :following_count,
           :total_tweets,
           :favorite_tweet,
           :retweet,
           :reply,
           :banner_image, to: :twitter_client

end
