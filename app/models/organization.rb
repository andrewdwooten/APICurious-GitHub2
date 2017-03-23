class Organization < OpenStruct
  attr_reader :service

  def self.service
    @service ||= GithubService.new
  end

  def self.organizations(username)
    service.organizations(username).map do |organization|
      Organization.new(organization)
    end
  end
end
