require 'spec_helper'
require_relative '../twitter_client'

RSpec.describe TwitterClient do
  describe '#send_tweets' do
    subject { described_class.new(tweets) }
    let(:twitter_client) { double(:twitter_client) }

    before do
      allow(subject).to receive(:twitter_client).and_return(twitter_client)
    end

    context 'when the array of tweets only contains one tweet' do
      let(:tweets) { ['This is one single tweet to update my status.'] }

      it 'sends just one tweet' do
        expect(twitter_client).to receive(:update).once
        subject.send_tweets
      end

      it 'sends the tweet in the array' do
        expect(twitter_client).to receive(:update).with(tweets.first, in_reply_to_status: nil)
        subject.send_tweets
      end
    end

    context 'when the array of tweets contains mulitiple tweets' do
      let(:tweets) { ['This is the first tweet in a thread', 'This is the second tweet in a thread', 'This is the third tweet in a thread'] }

      it 'sends each tweet in the array' do
        expect(twitter_client).to receive(:update).exactly(3).times
        subject.send_tweets
      end

      it 'chains the tweets in a twitter thread'
    end
  end
end
