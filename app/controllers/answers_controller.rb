class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:create, :new, :update, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)  do |answer|
      answer.user = current_user
    end
  end

  def  update
    @answer = Answer.find(params[:id])
    #if @answer.user == current_user
    @answer.update(answer_params)
    #end
    @question = @answer.question
  end

  def destroy
    @answer = Answer.find(params[:id])
    #if @answer.user == current_user
    @answer.destroy
    #end
    @question = @answer.question
    redirect_to questions_path, notice: "Your answer has been deleted"
  end

  private

  def answer_params
    params.require(:answer).permit(:content, attachments_attributes: [:file, :_destroy])
  end


end
