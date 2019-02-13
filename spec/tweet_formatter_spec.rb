require 'spec_helper'
require_relative '../lib/tweet_formatter'

RSpec.describe TweetFormatter do
  describe '#tweets' do
    subject { described_class.new(input: input) }

    context 'when the string passed in is less than 280 characters' do
      let(:input) { 'This is a single tweet less than 280 characters.' }

      it 'returns an array with one tweet' do
        expect(subject.tweets).to eq([input])
      end
    end

    context 'when the string passed in is longer than 280 characters' do
      let(:input) do
        %w[
          This is a long tweet that spans more than 280 characters. It can only be tweeted if
          willing to send several connected tweets. Let's hope this works. This is a long tweet
          that spans more than 280 characters. It can only be tweeted if willing to send several
          connected tweets. Let's hope this works. This is a long tweet that spans more than 280
          characters. It can only be tweeted if willing to send several connected tweets. Let's
          hope this works.
        ].join(' ')
      end

      it 'returns an array of tweets' do
        tweet_one = %w[
          1) This is a long tweet that spans more than 280 characters. It can only be tweeted if willing
          to send several connected tweets. Let's hope this works. This is a long tweet that spans more
          than 280 characters. It can only be tweeted if willing to send several connected tweets. Let's
        ].join(' ')

        tweet_two = %w[
          2) hope this works. This is a long tweet that spans more than 280 characters. It can only be
          tweeted if willing to send several connected tweets. Let's hope this works.
        ].join(' ')

        expect(subject.tweets).to eq([tweet_one, tweet_two])
      end

      it 'contains tweets that are enumerated' do
        expect(subject.tweets[0].start_with?('1) ')).to eq(true)
        expect(subject.tweets[1].start_with?('2) ')).to eq(true)
      end

      it 'removes starting whitespace from all tweets' do
        expect(subject.tweets[0].start_with?(' ')).to eq(false)
        expect(subject.tweets[1].start_with?(' ')).to eq(false)
      end

      it 'removes ending whitespace from all tweets' do
        expect(subject.tweets[0].end_with?(' ')).to eq(false)
        expect(subject.tweets[1].end_with?(' ')).to eq(false)
      end
    end
  end
end
