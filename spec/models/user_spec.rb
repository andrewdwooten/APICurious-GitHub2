require 'rails_helper'

describe User do
  attr_reader :user

  before(:each) do
    @user = User.create(name:  "andrewdwooten",
                        token: ENV['USER_TOKEN'])
  end

  describe '#followers' do
    it "returns array of followers names and urls" do
      VCR.use_cassette('/models/user/followers') do
        followers = @user.followers
        first = followers.first

        expect(followers.count).to eq(3)
        expect(first.login).to eq('CjMoore')
        expect(first.html_url).to eq('https://github.com/CjMoore')
        expect(first.class).to eq(Follow)
      end
    end
  end

  describe '#following' do
    it "returns array of follows the user is following" do
      VCR.use_cassette('/models/user/following') do
        following = user.following
        first = following.first

        expect(following.count).to eq(1)
        expect(first.login).to eq('blackknight75')
        expect(first.html_url).to eq('https://github.com/blackknight75')
        expect(first.class).to eq(Follow)
      end
    end
  end
  describe '#starred_count' do
    it "returns count of repos the user has starred" do
      VCR.use_cassette('/models/user/starred_count') do
        star_count = user.starred_count

        expect(star_count).to eq(1)
      end
    end
  end
  describe '#recent_commits' do
    it "returns users last ten commits" do
      VCR.use_cassette('/models/user/recent_commits') do
      commits = user.recent_commits
      commit  = commits.first

      expect(commits.count).to eq(10)
      expect(commit).to respond_to(:date)
      expect(commit).to respond_to(:repo_url)
      expect(commit).to respond_to(:message)
      end
    end
  end
  describe '#repositories_by_name' do
    it "returns array with Repository object for each of users repos" do
      VCR.use_cassette('/models/user/repositories_by_name') do
      repository_names = user.repositories_by_name
      first_repo  = repository_names.first

      expect(repository_names.count).to eq(30)
      expect(repository_names.class).to eq(Array)
      expect(first_repo.class).to eq(Repository)
      expect(first_repo).to respond_to(:name)
      expect(first_repo).to respond_to(:url_ext)
      expect(first_repo).to respond_to(:updated_at)
      end
    end
  end
  describe '#organizations' do
    it "returns array with Repository object for each of users repos" do
      VCR.use_cassette('/models/user/organizations') do
        organizations = user.organizations
        test_organization = organizations.first

        expect(organizations.count).to eq(1)
        expect(test_organization.login).to eq('APICuriousTest')
      end
    end
  end
  describe '#follow_activity' do
    it "returns array of recent commits for users the user is following" do
      VCR.use_cassette('/models/user/follow_activity') do
        recent_activity = user.follow_activity
        that_guy = recent_activity.first

        expect(recent_activity.count).to eq(1)
        expect(that_guy.keys[0]).to eq('blackknight75')
        expect(that_guy['blackknight75'].count).to eq(10)
        expect(that_guy['blackknight75'].first.class).to eq(Commit)
      end
    end
  end
  describe '#open_pull_requests' do
    it "returns array of pull requests the user has open" do
      VCR.use_cassette('/models/user/open_pull_requests') do
        pull_requests = user.open_pull_requests
        pr  = pull_requests.first

        expect(pull_requests.count).to eq(3)
        expect(pr.class).to eq(PullRequest)
        expect(pr).to respond_to(:repo)
        expect(pr).to respond_to(:title)
        expect(pr).to respond_to(:url)
      end
    end
  end
end
