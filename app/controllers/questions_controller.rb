class QuestionsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :new]

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to questions_path, notice: "Your question successfully created."
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:content, :title)
  end
end
