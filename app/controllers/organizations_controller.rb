class OrganizationsController < ApplicationController
  before_action :authorize!

  def index
    @organizations = current_user.organizations
  end
end
