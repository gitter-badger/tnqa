class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:create, :new, :update, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)  do |answer|
      answer.user = current_user
      authorize answer
    end
  end

  def  update
    @answer = Answer.find(params[:id])
    authorize @answer
    @question = @answer.question
    if @answer = current_user.answers.where(id: params[:id]).first
      @answer.update(answer_params)
      flash[:notice] = 'Ваш ответ был изменен'
      redirect_to question_path @question
    else
      redirect_to root_path, notice: "You are not allowed to update this answer"
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    authorize @answer
    question = @answer.question
    if @answer = current_user.answers.where(id: params[:id]).first
      @answer.destroy
      flash[:notice] = 'Ваш ответ был удален'
      redirect_to question_path question
    else
      redirect_to root_path, notice: "You are not allowed to delete this answer"
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, attachments_attributes: [:file, :_destroy])
  end


end
