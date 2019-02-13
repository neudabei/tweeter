#!/usr/bin/env ruby

require_relative 'twitter_client'
require_relative 'tweet_formatter'

class Tweeter
  def initialize
    @input = ARGF.read
  end

  def tweet
    tweet_formatter = TweetFormatter.new(input: input)
    tweets = tweet_formatter.tweets
    twitter_client = TwitterClient.new(tweets)
    twitter_client.send_tweets
  end

  private

  attr_reader :input
end
