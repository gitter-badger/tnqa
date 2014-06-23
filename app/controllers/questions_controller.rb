class QuestionsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :new, :update, :destroy]

  def index
    if params[:tag]
      @questions = Question.tagged_with(params[:tag]).page(params[:page])
    else
      @questions = Question.all.page(params[:page])
    end
  end

  def show
    question
    @answer = @question.answers.build
    #@answer.attachments.build
  end

  def new
    @question = Question.new
    #@question.attachments.build
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
    if @question = current_user.questions.where(id: params[:id]).first
    question.update(question_params) 
    flash[:notice] = "Your question has been updated"
  else
    redirect_to root_path, notice: "You are not allowed to update this question"
  end
  end

  def destroy
    question
    if @question = current_user.questions.where(id: params[:id]).first
    question.destroy
    redirect_to questions_path, notice: "Your question has been deleted"
  else
    redirect_to root_path, notice: "You are not allowed to delete this question"
  end
  end


  private

  def question
    @question ||= Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :title, :tag_list, attachments_attributes: [:file, :_destroy])
  end
end
