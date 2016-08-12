class DashboardsController < ApplicationController
  def index
  	@projects = current_user.projects
  	@todos = {}
  	# assign_proj_ids = current_user.projects.map{|proj| proj.assign_projects.where('status=?', ASSIGNED).pluck(:id)}.flatten #
  	# todos = Todo.where(assign_project_id: assign_proj_ids)
  	# AssignProject.joins(:user).where(status: ASSIGNED, project_id: user.projects.pluck(:id))
  	assign = AssignProject.joins(:user).where(status: ASSIGNED, project_id: current_user.projects.pluck(:id)).group(:user_id, :project_id)
  	develop = {}
  	assign.each do |as|
  		user_hash = {}
  		as.todos.each do |todo|
  		    user_email = as.user.email
  			develop[todo.status.to_s] = {} if not develop[todo.status.to_s].present?
  			develop[todo.status.to_s][user_email.to_s] = [] if not develop[todo.status.to_s][user_email.to_s].present?
  			develop[todo.status.to_s][user_email.to_s] << todo
  		end
  	end
  	@todos = develop
  	binding.pry
  	# current_user.projects.each do |proj|
  	# 	proj.assign_projects.where('status=?', ASSIGNED).each do ||
  	# end
  	# render 'projects/index'
  end
end
