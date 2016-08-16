class UsersController < ApplicationController
  autocomplete :user, :email
  
  def autocomplete_user_project
  	project = Project.find_by_id(params[:project_id])
  	@users = User.where("email like ?", "%"+params[:term]+"%")
  	@users = project.users.where(id: @users.pluck(:id))
  	respond_to do |format|
  		format.json{render :json => @users.pluck(:email)}
    end
  end
end
