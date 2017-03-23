require 'rails_helper'

describe Follow do
  describe '#followers' do
    it 'returns array of follows the user is following' do
      VCR.use_cassette('models/follow/followers') do
        followed = Follow.followers('andrewdwooten')
        first = followed.first

        expect(followed.count).to eq(1)
        expect(first.login).to eq('CjMoore')
      end
    end
  end
  describe '#following' do
    it 'returns array of followers the user is following' do
      VCR.use_cassette('models/follow/following') do
        following = Follow.following('andrewdwooten')
        first = following.first

        expect(following.count).to eq(1)
        expect(first.login).to eq('blackknight75')
      end
    end
  end
end
