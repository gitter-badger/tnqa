require_relative 'acceptance_helper'

feature 'update question', 'to correct info I want to update question' do

let(:user) {create(:user)}
let(:user2) {create(:user)}
let!(:question) {create(:question, user: user)}
let!(:question2) {create(:question, user: user2)}

  scenario 'owner updates question', js: true do
    sign_in(user)

    visit question_path(question)
    click_on 'E.Q.'
    fill_in("внесите изменения", with: "new question")
    click_on 'сохранить'

    expect(page).not_to have_content question.content
    expect(page).to have_content("new question")
  end

  scenario 'auth user updates question' do
    sign_in(user)

    visit question_path(question2)
save_and_open_page
    expect(page).to_not have_content("E.Q.")
  end

  scenario 'non-auth user updates question' do
    visit question_path(question)
    expect(page).to_not have_content("E.Q.")
  end
end
