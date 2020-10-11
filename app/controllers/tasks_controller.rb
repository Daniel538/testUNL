class TasksController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :user_dont_have_permissions

  before_action :set_project
  before_action :get_users, only: [:new, :edit]
  before_action :set_task, only: [:destroy, :edit, :update, :show]
  before_action :set_available_statuses, only: [:edit, :update, :show]
  before_action :has_access_to_change_status, only: :update

  def new
    @task = Project.new
    authorize @task
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
    authorize @task
    if @task.save
      status_changed_send_email
      redirect_to project_path(@project), notice: "The task was created successfully"
    else
      redirect_to project_path(@project), alert: @task.errors.full_messages
    end
  end

  def status_changed_send_email
    if ["in progress", "in review", "done"].include? @task.status
      TaskMailer.with(user: current_user, task: @task).task_changed.deliver_later
    else
      TaskMailer.with(user: @task.assignee, task: @task).task_changed.deliver_later
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
    unless current_user.admin? || @available_statuses.include?(task_params[:status]) && @task.assignee == current_user
      redirect_to project_path(@project), alert: "You don't have permissions for this status"
    end
  end

  def set_available_statuses
    config = {
      all: ["to do", "in progress", "in review", "done"],
      to_do: ["to do", "in progress"],
      in_progress: ["to do", "in progress", "in review"],
      in_review: [],
      done: []
    }
    @available_statuses = if current_user.admin? || @task.assignee == current_user
      current_user.admin ? config[:all] : config[@task.status.parameterize.underscore.to_sym]
    else
      []
    end
  end

  def task_params
    if params.has_key? :issue
      params[:task] = params.delete :issue
    elsif params.has_key? :story
      params[:task] = params.delete :story
    end
    if current_user.admin?
      params.require(:task).permit(:title, :description, :status, :assignee_id, :type)
    else
      params.require(:task).permit(:status)
    end
  end

  def set_project
    @project ||= Project.find(params[:project_id])
  end

  def set_task
    @task ||= @project.tasks.find(params[:id])
    authorize @task
  end

  def get_users
    @users = User.select("id, first_name, last_name")
  end
end
