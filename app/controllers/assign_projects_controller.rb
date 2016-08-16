class AssignProjectsController < ApplicationController
  before_action :set_assign_project, only: [:show, :edit, :update, :destroy]
  before_action :set_project
  before_action :set_user, only: [:show, :create, :update]

  def index
    @assign_projects = @project.assign_projects.where(status: ASSIGNED)
    @assign_project = AssignProject.new
  end

  def show
  end

  def new
    @assign_project = AssignProject.new
  end

  def edit
  end

  def create
    user_id = @user.id rescue nil
    @assign_project = @project.assign_projects.find_or_initialize_by(status: ASSIGNED, user_id: user_id)
    if @assign_project.persisted?
      respond_to do |format|
        flash[:warning] = "This project is already assign to #{@user.email} "
        format.js {render js: "window.location = '#{project_assign_projects_path(project_id: @project.id)}';"}
      end
    else
      redirect_to [@project, AssignProject], notice: 'Assign project was successfully created.' if @assign_project.save
    end
       
  end

  def update
    return render :edit if not @assign_project.update(assign_project_params)
    redirect_to [@project, AssignProject], notice: 'Assign project was successfully updated.'
  end

  def destroy
    @assign_project.destroy
    redirect_to [@project, AssignProject], notice: 'Assign project was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assign_project
      @assign_project = AssignProject.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
      if not @project
        redirect_to root_path, notice: 'Unauthorized access'  
      end
    end

    def set_user
      @user = User.find_by_email(params[:assign_project][:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assign_project_params
      params.require(:assign_project).permit(:users, :projects)
    end
end
