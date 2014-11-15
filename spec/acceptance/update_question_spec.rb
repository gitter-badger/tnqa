require_relative 'acceptance_helper'

feature 'update question', 'to correct info I want to update question' do

  let(:user) {create(:user)}
  let(:user2) {create(:user)}
  let!(:question) {create(:question, user: user)}
  let!(:question2) {create(:question, user: user2)}

  scenario 'auth user updates question' do
    sign_in(user)

    visit question_path(question2)
    expect(page).to_not have_content("E.Q.")
  end

  scenario 'non-auth user updates question' do
    visit question_path(question)
    expect(page).to_not have_content("E.Q.")
  end
end
