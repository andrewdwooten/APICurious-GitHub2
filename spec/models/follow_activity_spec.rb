require 'rails_helper'

describe FollowActivity do
  describe '#get_followed' do
    it 'returns array of follows the user is following' do
      VCR.use_cassette('models/follow_activity/get_followed')do
          followed = FollowActivity.get_followed('andrewdwooten')
          first = followed.first

          expect(followed.count).to eq(1)
          expect(first.login).to eq('blackknight75')
      end
    end
  end
  describe '#following_activity' do
    it 'returns recent commits of follows the user is following' do
      VCR.use_cassette('models/follow_activity/following_activity') do
        recent_activity = FollowActivity.following_activity('andrewdwooten')
        that_guy = recent_activity.first

        expect(recent_activity.count).to eq(1)
        expect(that_guy.keys[0]).to eq('blackknight75')
        expect(that_guy['blackknight75'].count).to eq(10)
        expect(that_guy['blackknight75'].first.class).to eq(Commit)
      end
    end
  end
end
