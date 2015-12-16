class TweetsController < ApplicationController
  def new
  end

  def create
    current_user.new_tweet(params[:tweet])
    redirect_to :back
  end
end
