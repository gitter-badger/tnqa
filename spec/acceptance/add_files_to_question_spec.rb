require_relative 'acceptance_helper'

feature 'add files to question', %q{
	to illustrate my question
	as an author
	I attach files to question
} do

let(:user) { create(:user) }

background do 
	 sign_in(user)
	 visit new_question_path
end

scenario 'auth user adds file to new question', js: true do
	fill_in 'Title', with: 'question title'
	fill_in 'Content', with: 'question content'
	attach_file 'Add file', "#{Rails.root}/spec/spec_helper.rb"
	click_on 'Create'

	expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'

 end
end
