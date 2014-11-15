class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:create, :new, :update, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params) do |answer|
      answer.user = current_user
      authorize answer
    end
  end

  def  update
    @answer = Answer.find(params[:id])
    authorize @answer
    @question = @answer.question
    if @answer.user == current_user
      @answer.update(answer_params)
    else
      flash[:error] = "редактирование доступно только автору"
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    authorize @answer
    question = @answer.question
    if @answer.user == current_user
      @answer.destroy
      redirect_to question
    else
      flash[:error] = "удаление доступно только автору"
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, attachments_attributes: [:file, :_destroy])
  end
end
