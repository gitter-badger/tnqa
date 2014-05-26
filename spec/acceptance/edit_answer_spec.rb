require_relative 'acceptance_helper'

feature 'Answer editing', 'an author can edit' do 
	let(:user) { create(:user) }
	let(:user2) { create(:user) }
	let(:question2) { create(:question, user: user2) }
	let!(:question) { create(:question, user: user) }
	let!(:answer) { create(:answer, question: question, user: user) }

	scenario 'non-auth user edits answer' do
		visit question_path(question)
		expect(page).to_not have_link "Edit"
	end

describe "Authenticated user" do
	before do
    sign_in(user)
	end

	scenario 'owner sees edit link' do
		visit question_path(question)
		within '.answers' do
		#binding.pry
		expect(page).to have_link "Edit"
		end
  end
  scenario 'owner edits answer', js: true do
  	visit question_path(question)
  	within '.answers' do
  		click_on "Edit"
  	  fill_in "Answer", with: "editing answer"
  	  click_on "Save"

  	expect(page).not_to have_content answer.content
  	expect(page).to have_content 'editing answer'
   end
  end

  scenario 'auth user edits answer', js: true do
		visit question_path(question2)
    within '.answers' do
		 expect(page).to_not have_link "Edit"
   end
  end
 end
end