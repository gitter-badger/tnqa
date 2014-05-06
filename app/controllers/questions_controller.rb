class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit]
  before_action :authenticate_user!, only: [:create, :new]

  def index
    @questions = Question.all
  end

  def show
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

def edit
end

  private

  def load_question
  	@question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :title)
  end
end
