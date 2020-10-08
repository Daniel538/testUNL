class TasksController < ApplicationController
  before_action :authenticate_user!, :set_project
  before_action :is_admin, except: :show
  before_action :get_users, only: [:new, :edit]
  before_action :set_task, only: [:destroy, :edit, :update, :show]
  before_action :set_available_statuses, only: [:edit, :update]
  before_action :has_access_to_change_status, only: [:update]

  def new
  end

  def edit
  end

  def show
  end

  def update
    old_status = @task.status
    if @task.update(task_params)
      if @task.status != old_status
        status_changed_send_email
      end
      redirect_to project_path(@project), notice: "The task was edited successfully"
    else
      redirect_to project_path(@project), alert: @task.errors.full_messages
    end
  end

  def create
    @task = @project.tasks.create(task_params.merge(created_by: current_user, status: "to do"))
    if @task.save
      TaskMailer.with(user: @task.assignee, task: @task).task_changed.deliver_later
      redirect_to project_path(@project), notice: "The task was created successfully"
    else
      redirect_to project_path(@project), alert: @task.errors.full_messages
    end
  end

  def status_changed_send_email
    if ["in progress", "in review", "done"].include? @task.status
      TaskMailer.with(user: current_user, task: @task).task_changed.deliver_later
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

  def has_access_to_change_status
    params_status = task_params.has_key?(:status) ? task_params[:status] : false
    unless params_status && @available_statuses.include?(params_status)
      redirect_to project_path(@project), alert: "You don't have permissions for this status"
    end
  end

  def set_available_statuses
    config = {
      all: ["to do", "in progress", "in review", "done"],
      to_do: ["in progress"],
      in_progress: ["to do", "in review"],
      in_review: [],
      done: []
    }
    @available_statuses = current_user.admin ? config[:all] : config[@task.status.parameterize.underscore.to_sym]
  end

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
