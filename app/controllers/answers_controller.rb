class AnswersController < ApplicationController



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

private

def answer_params
params.require(:answer).permit(:content, attachments_attributes: [:file])	
end


end
