class DashboardsController < ApplicationController
  def index
  	@projects = current_user.projects
  	@todos = {}
  	assign = AssignProject.joins(:user).where(status: ASSIGNED, project_id: current_user.projects.pluck(:id)).group(:user_id, :project_id)
  	develop = {}
    @users = User.where(id: AssignProject.where(status: ASSIGNED, project_id: User.first.projects.pluck(:id)).pluck(:user_id)).select(:id, :email)
    projects = {}
    current_user.projects.each do |project|
      projects["proj_"+project.id.to_s] = {} if not projects["proj_"+project.id.to_s].present?
      projects["proj_"+project.id.to_s]["status"] = project.users.pluck(:email)
      project.todos.each do |todo|
        projects["proj_"+project.id.to_s][todo.status.to_s] = {} if not projects["proj_"+project.id.to_s][todo.status.to_s] .present?
        projects["proj_"+project.id.to_s][todo.status.to_s][todo.assign_project.user.email.to_s] = [] if not projects["proj_"+project.id.to_s][todo.status.to_s][todo.assign_project.user.email.to_s]
        projects["proj_"+project.id.to_s][todo.status.to_s][todo.assign_project.user.email.to_s] << todo
      end
    end
    @projects = projects
    @project = Project.find_by_id(params[:project_id])
   
  end
end
