class DashboardController < ApplicationController
  before_action :authorize!

  def index
    @followers  = current_user.followers
    @star_count = current_user.starred_count
    @following  = current_user.following
  end
end
