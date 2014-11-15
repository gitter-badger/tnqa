class CommentsController < ApplicationController
  helper_method :object
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def create
    @comment = object.comments.build(comment_params)
    @comment.user = current_user
    authorize @comment
    @comment.save
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.user == current_user
    @comment.update(comment_params)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.user == current_user
    @comment.destroy
    end
  end

  private

  def object
    @object ||= if params[:question_id]
      Question.find(params[:question_id])
    elsif params[:answer_id]
      Answer.find(params[:answer_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
