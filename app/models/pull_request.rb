class PullRequest < OpenStruct
  attr_reader :service

  def self.service
    @service ||= GithubService.new
  end

  def self.get_repos(username)
    Repository.repositories_by_name(username)
  end

  def self.pull_requests(username)
    raw_pull_requests = get_repos(username).map do |repo|
                          service.pull_requests(username, repo.name)
    end
    clear_empty_repos(raw_pull_requests, username)
  end

  def self.clear_empty_repos(array_o_prs, username)
    array_o_prs.delete_if {|e| e.empty?}
    filter_by_user_and_format(array_o_prs, username)
  end

  def self.filter_by_user_and_format(array_o_prs, username)
    pulls = []
    array_o_prs.each do |repo|
      repo.each do |pull|
          pulls <<  PullRequest.new(repo:  pull[:base][:repo][:name],
                                    title: pull[:title],
                                    url:   pull[:html_url]) if pull[:user][:login] == username
      end
    end
    pulls
  end
end
