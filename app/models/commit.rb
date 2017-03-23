class Commit < OpenStruct
  attr_reader :service

  def self.service
    @service ||= GithubService.new
  end

  def self.recent(username)
    repo_names = service.repositories(username).map do |repo|
                    repo[:name]
                 end
    repo_commits = repo_names.map do |repo|
      service.commits(username, repo)
    end
    clear_empty_repos(repo_commits, username)
  end

  def self.clear_empty_repos(repo_commits, username)
    repo_commits.delete_if {|repo| repo.empty? || repo.class == Hash}
    format_commits(repo_commits, username)
  end

  def self.format_commits(repo_commits, username)
    commits = []
    repo_commits.each do |repo|
      repo.each do |commit|
        commits << Commit.new({date:     commit[:commit][:author][:date].to_time.in_time_zone,
                               repo_url: commit[:html_url],
                               message:  commit[:commit][:message]})
      end
    end
    commits[0..9]
  end

end
