class RepositoriesController < ApplicationController
  before_action :authorize!

  def index
    @repositories = current_user.repositories_by_name
  end

  def new
  end

  def create
    current_user.create_repo(params[:name])
    redirect_to repositories_path
  end
end
