class QuestionsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :new, :update, :destroy]

  def index
    @questions = Question.all.page params[:page]
  end

  def show
    question
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to question_path(@question), notice: "Your question successfully created."
    else
      render :new
    end
  end

  def edit
    question
  end

  def update
    if question.update(question_params)
      redirect_to @question, notice: "Your question has been updated"
    else
      render :edit
    end
  end

  def destroy
    question.destroy
    redirect_to questions_path, notice: "Your question has been deleted"
  end


  private

  def question
    @question ||= Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :title)
  end
end
