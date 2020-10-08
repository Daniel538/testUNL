class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params.merge(user_id: current_user.id))

    if @comment.save
      redirect_back fallback_location: home_path, notice: "Your comment was successfully posted!"
    else
      redirect_back fallback_location: home_path, alert: @comment.errors.full_messages
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Task.find_by_id(params[:task_id]) if params[:task_id]
  end

end
