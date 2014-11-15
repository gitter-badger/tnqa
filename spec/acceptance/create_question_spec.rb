require_relative 'acceptance_helper'

feature 'create question', 'to qet answer being auth. I want to ask' do

  let!(:user) {create(:user)}

  scenario 'auth user create q', js: true do
    sign_in(user)
    visit root_path
    click_on 'ЗАДАТЬ ВОПРОС'
    fill_in 'Заголовок', with: 'my title'
    fill_in 'Вопрос', with: 'my content'
    fill_in 'Тэги', with: 'my'
    click_on 'Опубликовать вопрос'
    sleep 2
    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'non-auth user create q' do
    visit '/questions'
    expect(page).to_not have_content("ЗАДАТЬ ВОПРОС")
  end
end
