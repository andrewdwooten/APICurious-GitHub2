class Follow < OpenStruct
  attr_reader :service

  def self.service
    @service ||= GithubService.new
  end

  def self.followers(username)
    service.followers(username).map do |follower|
      Follow.new(follower)
    end
  end

  def self.following(username)
    service.following(username).map do |followed|
      Follow.new(followed)
    end
  end

end
