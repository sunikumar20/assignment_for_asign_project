class DashboardsController < ApplicationController
  def index
  	@projects = current_user.projects
  	@todos = {}
  	# assign_proj_ids = current_user.projects.map{|proj| proj.assign_projects.where('status=?', ASSIGNED).pluck(:id)}.flatten #
  	# todos = Todo.where(assign_project_id: assign_proj_ids)
  	# AssignProject.joins(:user).where(status: ASSIGNED, project_id: user.projects.pluck(:id))
  	assign = AssignProject.joins(:user).where(status: ASSIGNED, project_id: current_user.projects.pluck(:id)).group(:user_id, :project_id)
  	develop = {}
    # if current_user.has_role? :admin
    #   project_id = current_user.projects.pluck(:id)
    # else
    # @user = current_user.projects
    #   @projects = Project.joins(:assign_projects).where(assign_projects: {status: ASSIGNED, user_id: user.id})
    # # end
    @users = User.where(id: AssignProject.where(status: ASSIGNED, project_id: User.first.projects.pluck(:id)).pluck(:user_id)).select(:id, :email)
    projects = {}
    # User.first.projects.each do |proj|
    #   projects[proj.name] if not projects[proj.name].present?
    # end
    current_user.projects.each do |project|
      projects["proj_"+project.id.to_s] = {} if not projects["proj_"+project.id.to_s].present?
      projects["proj_"+project.id.to_s]["status"] = project.users.pluck(:email)
      # projects[project.name.to_s][project_detail] = 
      project.todos.each do |todo|
        # projects["proj_"+project.id.to_s][todo.assign_project.user.email.to_s] = [] if not projects["proj_"+project.id.to_s][todo.assign_project.user.email.to_s].present?
        projects["proj_"+project.id.to_s][todo.status.to_s] = {} if not projects["proj_"+project.id.to_s][todo.status.to_s] .present?
        projects["proj_"+project.id.to_s][todo.status.to_s][todo.assign_project.user.email.to_s] = [] if not projects["proj_"+project.id.to_s][todo.status.to_s][todo.assign_project.user.email.to_s]
        projects["proj_"+project.id.to_s][todo.status.to_s][todo.assign_project.user.email.to_s] << todo
      end
    end
    @projects = projects
   
  end
end
