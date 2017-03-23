class CommitsController < ApplicationController
  before_action :authorize!

  def index
    @commits = current_user.recent_commits
  end
end
