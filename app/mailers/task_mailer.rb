class TaskMailer < ApplicationMailer

  def task_changed
    @user = params[:user]
    @task = params[:task]
    mail(to: @user.email, subject: @task.title)
  end
end
