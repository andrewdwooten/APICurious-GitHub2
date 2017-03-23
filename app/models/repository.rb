class Repository < OpenStruct
  attr_reader :service

  def self.service
    @service ||= GithubService.new
  end

  def self.count_of_starred(username)
    service.starred_repositories(username).count
  end

  def self.repositories_by_name(username)
    service.repositories(username).map do |repo|
      Repository.new({name:       repo[:name],
                      url_ext:    repo[:full_name],
                      updated_at: repo[:updated_at].to_time.in_time_zone })
    end
  end

  def self.create(token, repo_name)
    service.create_repo(token, repo_name)
  end

end
