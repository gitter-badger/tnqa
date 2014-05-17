require_relative 'acceptance_helper'

feature 'update question', 'to correct info I want to update question' do

let(:user) {create(:user)}
let(:user2) {create(:user)}
let(:question) {create(:question, user: user)}
let(:question2) {create(:question, user: user2)}

  scenario 'owner updates question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Edit'
    fill_in("Title", with: "My Title")
    fill_in("Content", with: 'My Body')
    click_on 'Update'
    expect(question.reload.title).to eq "My Title"
    expect(question.reload.content).to eq 'My Body'
    expect(page).to have_content("Your question has been updated")
  end

  scenario 'auth user updates question' do
    sign_in(user)

    visit question_path(question2)
    expect(page).to_not have_content("Edit")
  end

  scenario 'non-auth user updates question' do
    visit question_path(question)
    expect(page).to_not have_content("Edit")
  end
end
