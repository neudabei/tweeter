require 'spec_helper'
require_relative '../../main'

RSpec.describe 'Interacting with tweeter' do
  context 'passing a string shorter than 280 characters to tweeter' do
    let(:my_short_tweet) { "my single tweet about what's good" }

    before do
      allow(ARGF).to receive(:read) { my_short_tweet }
    end

    it 'tweets the string as is' do
      tweeter = Tweeter.new
      tweeter.parse_input
      tweeter.add_numbering_to_list

      expect(tweeter.tweets).to eq([my_short_tweet])
    end
  end

  context 'passing a string longer than 280 characters to tweeter' do
    let(:my_long_tweet) { "This is a long tweet that spans more than 280 characters. It can only be tweeted if willing to send several connected tweets. Let's hope this works. This is a long tweet that spans more than 280 characters. It can only be tweeted if willing to send several connected tweets. Let's hope this works. This is a long tweet that spans more than 280 characters. It can only be tweeted if willing to send several connected tweets. Let's hope this works." }

      let(:tweeter) { Tweeter.new }

    before do
      allow(ARGF).to receive(:read) { my_long_tweet }

      tweeter.parse_input
      tweeter.add_numbering_to_list
    end

    it 'splits the string into separate tweets' do
      tweet_one = "1) This is a long tweet that spans more than 280 characters. It can only be tweeted if willing to send several connected tweets. Let's hope this works. This is a long tweet that spans more than 280 characters. It can only be tweeted if willing to send several connected tweets. Let's"
      tweet_two = "2) hope this works. This is a long tweet that spans more than 280 characters. It can only be tweeted if willing to send several connected tweets. Let's hope this works."

      puts tweeter.tweets.inspect
      expect(tweeter.tweets).to eq([tweet_one, tweet_two])
    end

    it 'begins each tweet with an enumerator' do
      tweeter.tweets.each_with_index do |tweet, index|
        expect(tweet.start_with?("#{index+1}) ")).to be_truthy
      end
    end

    it "it does not begin tweets with a whitespace" do
      tweeter.tweets.each do |tweet|
        expect(tweet.start_with?(" ")).to be_falsy
      end
    end

    it "does not end tweets with a whitespace" do
      tweeter.tweets.each do |tweet|
        expect(tweet.end_with?(" ")).to be_falsy
      end
    end

    it "does not end tweets with a newline" do
      tweeter.tweets.each do |tweet|
        expect(tweet.end_with?("\n")).to be_falsy
      end
    end
  end
end
