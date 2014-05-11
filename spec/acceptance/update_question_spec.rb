require 'spec_helper'

feature 'update question', 'to correct info I want to update question' do

let(:user) {create(:user)}
let(:user2) {create(:user)}
let(:question) {create(:question, user: user)}
let(:question2) {create(:question, user: user2)}

  scenario 'owner update question' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'

    visit "/questions/#{question[:id]}"
    click_on 'Edit'
    fill_in("Title", with: "My Title")
    fill_in("Content", with: 'My Body')
    click_on 'Update'
    expect(question.reload.title).to eq "My Title"
    expect(question.reload.content).to eq 'My Body'
    expect(page).to have_content("Your question has been updated")
  end

  scenario 'auth user update question' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'

    visit "/questions/#{question2[:id]}"
    expect(page).to_not have_content("Edit")
  end

  scenario 'non-auth user update question' do
    visit "/questions/#{question[:id]}"
    expect(page).to_not have_content("Edit")
  end
end
