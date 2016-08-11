class DashboardsController < ApplicationController
  def index
  	@projects = current_user.projects
  	render 'projects/index'
  end
end
