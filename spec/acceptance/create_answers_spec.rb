require_relative 'acceptance_helper'

feature 'User answer', 'to help friends I answer their questions' do

  let(:user) { create(:user, :with_reputation) }
  let(:question) { create(:question)}

  scenario 'auth user create answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'ваш ответ', with: 'My answer'
    click_on 'Добавьте ответ'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'My answer'
    end
  end

  scenario 'auth user try to create invalid answer', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Добавьте ответ'
    expect(page).to have_content "Content can't be blank"
  end
end
