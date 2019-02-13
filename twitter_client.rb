require 'twitter'
require 'dotenv/load'

class TwitterClient
  def initialize(tweets)
    @tweets = tweets
  end

  def send_tweets
    previous_tweet = nil
    tweets.each do |tweet_content|
      previous_tweet = twitter_client.update(tweet_content, in_reply_to_status: previous_tweet)
    end
  end

  private

  attr_reader :tweets

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_API_SECRECT_KEY"]
      config.access_token        = ENV["TWITTER_API_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_API_ACCESS_TOKEN_SECRET"]
    end
  end
end
