class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :show, :destroy]
  def index
    @projects = Project.order(id: :desc).page(params[:page])
  end

  def new
    @project = Project.new
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'The project was edited successfully'
    else
      render :edit
    end
  end

  def create
    #render plain: params[:project].inspect
    @project = Project.new(project_params)
    if @project.save
      redirect_to home_path, notice: 'The project was created successfully'
    else
      render :new
    end
  end

  def destroy
    if @project.destroy
      redirect_to home_path, notice: 'The project was deleted successfully'
    else
      redirect_to home_path, alert: 'Undefined exception. Try again.'
    end
  end

  private
  def project_params
    params.require(:project).permit(:name,:summary,:start_date,:end_date)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
