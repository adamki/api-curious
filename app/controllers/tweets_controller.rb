class TweetsController < ApplicationController
  def new
  end

  def create
    current_user.new_tweet(params[:tweet])
    redirect_to :back
  end

  def favorite
    current_user.favorite_tweet(params[:tweet_id])
    flash[:success] = "This tweet has been favorited"
    redirect_to :back
  end

  def retweet
    current_user.retweet(params[:tweet_id])
    flash[:success] = "This Retweet has been completed"
    redirect_to :back
  end
end
