require 'spec_helper'
require_relative '../../lib/tweeter'
require_relative '../../lib/twitter_client'
require_relative '../../lib/tweet_formatter'

RSpec.describe 'Interacting with tweeter' do
  describe 'passing a string of less than 280 characters to tweeter' do
    let(:twitter_client) { double(:twitter_client) }
    let(:previous_tweet) { double(:previous_tweet) }
    let(:my_short_tweet) { 'my short tweet' }

    before do
      allow(ARGF).to receive(:read) { my_short_tweet }
      allow(Twitter::REST::Client).to receive(:new).and_return(twitter_client)
      allow(twitter_client).to receive(:update).with(my_short_tweet, in_reply_to_status: nil).and_return(previous_tweet)
    end

    it 'sends a single tweet' do
      tweeter = Tweeter.new
      tweeter.tweet

      expect(twitter_client).to have_received(:update).with(my_short_tweet, in_reply_to_status: nil)
    end
  end

  describe 'passing in a long string of more than 280 characters' do
    let(:twitter_client) { double(:twitter_client) }
    let(:previous_tweet) { double(:previous_tweet) }
    let(:my_long_tweet) do
      %w[
          This is a long tweet that spans more than 280 characters. It can only be tweeted if
          willing to send several connected tweets. Let's hope this works. This is a long tweet
          that spans more than 280 characters. It can only be tweeted if willing to send several
          connected tweets. Let's hope this works. This is a long tweet that spans more than 280
          characters. It can only be tweeted if willing to send several connected tweets. Let's
          hope this works.
      ].join(' ')
    end

    let(:tweet_one) do %w[
        1) This is a long tweet that spans more than 280 characters. It can only be tweeted if willing
        to send several connected tweets. Let's hope this works. This is a long tweet that spans more
        than 280 characters. It can only be tweeted if willing to send several connected tweets. Let's
      ].join(' ')
    end

    let(:tweet_two) do %w[
        2) hope this works. This is a long tweet that spans more than 280 characters. It can only be
        tweeted if willing to send several connected tweets. Let's hope this works.
      ].join(' ')
    end

    before do
      allow(ARGF).to receive(:read) { my_long_tweet }
      allow(Twitter::REST::Client).to receive(:new).and_return(twitter_client)
      allow(twitter_client).to receive(:update).and_return(previous_tweet)
    end

    it 'sends multiple tweets' do
      tweeter = Tweeter.new
      tweeter.tweet

      expect(twitter_client).to have_received(:update).with(tweet_one, in_reply_to_status: nil).once
      expect(twitter_client).to have_received(:update).with(tweet_two, in_reply_to_status: previous_tweet).once
    end
  end
end
