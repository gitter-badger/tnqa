# require_relative 'acceptance_helper'

# feature 'add files to question', %q{
# 	to illustrate my question
# 	as an author
# 	I attach files to question
# } do

# let(:user) { create(:user) }

# background do 
# 	 sign_in(user)
# 	 visit new_question_path
# end

# scenario 'auth user adds file to new question', js: true do
# 	fill_in 'заголовок вопроса', with: 'question title'
# 	fill_in 'текст вопроса', with: 'question content'
# 	attach_file 'Choose File', "#{Rails.root}/spec/spec_helper.rb"
# 	click_on 'Создать вопрос'

# 	expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'

#  end
# end
