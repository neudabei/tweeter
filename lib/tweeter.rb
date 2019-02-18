require_relative 'twitter_client'
require_relative 'tweet_formatter'

class Tweeter
  def initialize
    validate_input
  end

  def tweet
    tweet_formatter = TweetFormatter.new(input: input)
    tweets = tweet_formatter.tweets
    twitter_client = TwitterClient.new(tweets)
    twitter_client.send_tweets
  end

  private

  attr_reader :input

  def validate_input
    @input = ARGF.read
    if @input.chomp == ''
      abort 'No input provided. Try echo -n `"My tweet" | ruby main.rb`'
    end
  end
end
