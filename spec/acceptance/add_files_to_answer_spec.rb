require_relative 'acceptance_helper'

feature 'add files to answer', %q {
	toillustratemy
	answer
ownerattachesfiles
} do 

let(:user) { create(:user)}
let!(:question) { create(:question)}

background do
	sign_in(user)
	visit question_path(question)	
end

scenario 'user adds file when answers', js: true do
	fill_in 'ваш ответ', with: 'My answer'
	click_on 'добавить файл'
	attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
	click_on 'Добавьте ответ'

	within '.answers' do
		expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
	end
 end
end