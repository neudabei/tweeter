#!/usr/bin/env ruby

class Tweeter
  TWEET_LENGTH = 280

  attr_reader :tweets

  def initialize
    @tweets = Array.new
  end

  def parse_input
    input = ARGF.read

    until input.size <= TWEET_LENGTH do
      index_of_last_ocurrence_of_space = input.rindex(' ', TWEET_LENGTH)
      tweet = input.slice!(0, index_of_last_ocurrence_of_space)
      tweet.lstrip!

      @tweets << tweet
    end

    @tweets << input.lstrip
  end

  def add_numbering_to_list
    if @tweets.count > 1

      @tweets = @tweets.map.with_index do |element, index|
        "#{index + 1}" +  ') ' + element.to_s
      end
    end
  end
end

tweeter = Tweeter.new
tweeter.parse_input
tweeter.add_numbering_to_list
