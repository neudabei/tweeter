class TweetFormatter
  TWEET_LENGTH = 280

  attr_reader :tweets

  def initialize(input:)
    @input = input
    @tweets = Array.new

    process_input
  end

  private

  attr_reader :input

  def slice_input
    until input.size <= TWEET_LENGTH do
      index_of_last_ocurrence_of_space = input.rindex(' ', TWEET_LENGTH)
      tweet = input.slice!(0, index_of_last_ocurrence_of_space)
      tweet.lstrip!

      tweets << tweet
    end

    tweets << input.lstrip
  end

  def add_numbering_to_list_of_tweets
    if tweets.count > 1

      @tweets = tweets.map.with_index do |element, index|
        "#{index + 1}" +  ') ' + element.to_s
      end
    end
  end

  def process_input
    slice_input
    add_numbering_to_list_of_tweets
  end
end
