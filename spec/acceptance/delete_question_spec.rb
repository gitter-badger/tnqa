require 'spec_helper'

feature 'delete question', 'I want to delete question' do

let(:user) {create(:user)}
let(:user2) {create(:user)}
let(:question) {create(:question, user: user)}
let(:question2) {create(:question, user: user2)}
  scenario 'owner delete question' do
    sign_in(user)

    visit "/questions/#{question[:id]}"
    click_on 'Edit'
    click_on 'Delete'
    expect(page).to have_content("Your question has been deleted")
  end

  scenario 'auth user delete question' do
    sign_in(user)

    visit "/questions/#{question2[:id]}"
    expect(page).to_not have_content("Edit")
  end

  scenario 'non-auth user delete question' do
    visit "/questions/#{question[:id]}"
    expect(page).to_not have_content("Edit")
  end
end
