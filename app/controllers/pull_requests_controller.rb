class PullRequestsController < ApplicationController
  before_action :authorize!

  def index
    @pull_requests = current_user.open_pull_requests
  end
end
