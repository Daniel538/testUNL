class TasksController < ApplicationController
  before_action :authenticate_user!, :set_project
  before_action :is_admin, except: :show
  before_action :get_users, only: [:new, :edit]
  before_action :set_task, only: [:destroy, :edit, :update, :show]

  def new
  end

  def edit
  end

  def show
  end

  def update
    if @task.update(task_params)
      redirect_to project_path(@project), notice: "The task was edited successfully"
    else
      redirect_to project_path(@project), alert: @task.errors.full_messages
    end
  end

  def create
    @task = @project.tasks.create(task_params.merge(created_by: current_user))
    if @task.save
      redirect_to project_path(@project), notice: "The task was created successfully"
    else
      redirect_to project_path(@project), alert: @task.errors.full_messages
    end
  end

  def destroy
    if @task.destroy
      redirect_to @project, notice: "The task was deleted successfully"
    else
      redirect_to @project, alert: "Undefined exception. Try again."
    end
  end



  private

  def task_params
    if params.has_key? :issue
      params[:task] = params.delete :issue
    elsif params.has_key? :story
      params[:task] = params.delete :story
    end
    params.require(:task).permit(:title, :description, :status, :assignee_id, :type)
  end

  def set_project
    @project ||= Project.find(params[:project_id])
  end

  def set_task
    @task ||= @project.tasks.find(params[:id])
  end

  def get_users
    @users = User.select("id, first_name, last_name")
  end

end
