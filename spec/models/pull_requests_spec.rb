require 'rails_helper'

describe PullRequest do
  describe '#pull_requests' do
    it "returns all pull_requests the user has opened in their repos" do
      VCR.use_cassette('/models/pull_requests/pull_requests') do
          pull_requests = PullRequest.pull_requests('andrewdwooten')
          pr  = pull_requests.first

          expect(pull_requests.count).to eq(3)
          expect(pr.class).to eq(PullRequest)
          expect(pr).to respond_to(:repo)
          expect(pr).to respond_to(:title)
          expect(pr).to respond_to(:url)
      end
    end
  end
  describe '#get_repos' do
    it "returns all repos by name the user has" do
      VCR.use_cassette('models/pull_requests/get_repos') do
        repository_names = PullRequest.get_repos('andrewdwooten')
        first_repo = repository_names.first


        expect(repository_names.count).to eq(30)
        expect(repository_names.class).to eq(Array)
        expect(first_repo.class).to eq(Repository)
        expect(first_repo).to respond_to(:name)
        expect(first_repo).to respond_to(:url_ext)
        expect(first_repo).to respond_to(:updated_at)
      end
    end
  end
end
