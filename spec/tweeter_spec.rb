require 'spec_helper'
require_relative '../lib/tweeter'

RSpec.describe Tweeter do
  subject { described_class.new }
  let(:my_short_tweet) { "my single tweet about what's good" }

  before do
    allow(ARGF).to receive(:read) { my_short_tweet }
  end

  it 'take input from STDIN and assigns it to @input' do
    input = subject.instance_variable_get(:@input)
    expect(input).to eq(my_short_tweet)
  end

  describe '#tweet' do
    let(:twitter_client) { double(:twitter_client, send_tweets: 'ok') }
    let(:tweet_formatter) { double(:tweet_formatter, tweets: tweets) }
    let(:tweets) { [my_short_tweet] }

    before do
      allow(TwitterClient).to receive(:new).with(tweets).and_return(twitter_client)
      allow(TweetFormatter).to receive(:new).with(input: my_short_tweet).and_return(tweet_formatter)
    end

    it 'passes the input to TweetFormatter' do
      expect(TweetFormatter).to receive(:new).with(input: my_short_tweet)
      subject.tweet
    end

    it 'sends the formatted tweets to twitter' do
      expect(twitter_client).to receive(:send_tweets).and_return('ok')
      subject.tweet
    end

    describe 'validating input' do
      context 'when no input is provided' do
        let(:my_short_tweet) { '' }

        it 'aborts and prints an error message' do
          expect(subject).to receive(:abort).with('No input provided. Try echo -n `"My tweet" | ruby main.rb`')
          subject.tweet
        end
      end

      context 'when only a new line is provided' do
        let(:my_short_tweet) { "\n" }

        it 'aborts and prints an error message' do
          expect(subject).to receive(:abort).with('No input provided. Try echo -n `"My tweet" | ruby main.rb`')
          subject.tweet
        end
      end
    end
  end
end
