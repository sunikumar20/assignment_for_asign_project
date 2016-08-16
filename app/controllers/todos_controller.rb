class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :set_project
  def index
    @todos = @project.todos
    @todo = Todo.new
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def edit
  end

  def create
    @todo = Todo.new(todo_params)
    redirect_to [@project, Todo], notice: 'Todo was successfully created.' if @todo.save
       
  end

  def update
    return render :edit unless @todo.update(todo_params)
    redirect_to [@project, Todo], notice: 'Todo was successfully updated.' 
  end

  def destroy
    @todo.destroy
    redirect_to [@project, Todo], notice: 'Todo was successfully destroyed.' 
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
      if not @project
        redirect_to root_path, notice: 'Unauthorized access'  
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit!
    end
end
