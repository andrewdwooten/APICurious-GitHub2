require 'rails_helper'

describe Commit do
  describe '#recent' do
    it "returns 10 most recent commits" do
      VCR.use_cassette('models/commit/recent_commits') do
        commits = Commit.recent('andrewdwooten')
        commit  = commits.first

        expect(commits.count).to eq(10)
        expect(commit).to respond_to(:date)
        expect(commit).to respond_to(:repo_url)
        expect(commit).to respond_to(:message)
      end
    end
  end
end
