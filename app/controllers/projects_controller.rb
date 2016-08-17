class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @project = Project.find_by_id(params[:project_id]) if params[:project_id].present?
    @projects = current_user.projects
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = current_user.projects.create(project_params)
    return render :new  if @project.errors.present?
    redirect_to projects_path, notice: 'Project was successfully created.'
  end

  def update
    return render :edit if not @project.update(project_params)
    redirect_to projects_path, notice: 'Project was successfully updated.'
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
