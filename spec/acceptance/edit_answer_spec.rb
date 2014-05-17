require_relative 'acceptance_helper'

feature 'Answer editing', 'an author can edit' do 
	let!(:user) { create(:user) }
	let!(:question) { create(:question) }
	let!(:answer) { create(:answer) }

	scenario 'unauth try to edit' do
		visit question_path(question)
		expect(page).to_not have_link "Edit"
	end

describe "Authenticated user" do
	before do
    sign_in user
		visit question_path(question)
	end

	scenario 'auth sees edit link' do
		within '.answers' do
			expect(page).to have_link "Edit"
		end
  end
  scenario 'try to edit his answer', js: true do
  	click_on "Edit"
  	within '.answers' do
  	  fill_in "Answer", with: "editing answer"
  	  click_on "Save"

  	expect(page).not_to have_content answer.content
  	expect(page).to have_content 'edited answer'
  	expect(page).to_not have_selector 'textarea'
   end
  end

  	scenario 'editing other user question' do
  	end

	end
end