class GithubService
  attr_reader :connection, :auth

  def initialize
    @connection = Faraday.new('https://api.github.com')
    @auth       = "?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"
  end

  def repositories(username)
    parse(connection.get("/users/#{username}/repos#{auth}"))
  end

  def followers(username)
    parse(connection.get("/users/#{username}/followers#{auth}"))
  end

  def starred_repositories(username)
    parse(connection.get("/users/#{username}/starred#{auth}"))
  end

  def following(username)
    parse(connection.get("/users/#{username}/following#{auth}"))
  end

  def commits_to_repo(username, repo_name)
    parse(connection.get("/repos/#{username}/#{repo_name}/commits#{auth}&author=#{username}"))
  end

  def commits(username, repo_name)
    parse(connection.get("/repos/#{username}/#{repo_name}/commits#{auth}&author=#{username}&since=1.week.ago"))
  end

  def organizations(username)
    parse(connection.get("/users/#{username}/orgs#{auth}"))
  end

  def create_repo(token, repo_name)
    connection.post do |req|
      req.url "/user/repos#{auth}&access_token=#{token}"
      req.body = { "name": repo_name }.to_json
    end
  end

  def pull_requests(username, repo_name)
    parse(connection.get("/repos/#{username}/#{repo_name}/pulls#{auth}&state=open"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
