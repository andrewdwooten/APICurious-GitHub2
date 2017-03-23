class FollowActivity < OpenStruct
  attr_reader :service

  def self.service
    @service ||= GithubService.new
  end

  def self.get_followed(username)
    Follow.following(username)
  end

  def self.following_activity(username)
    get_followed(username).map do |user|
      {user.login => Commit.recent(user.login)}
    end
  end
end
