require 'spec_helper'

feature 'delete question', 'I want to delete question' do

  scenario 'owner delete question' do
    User.create!(email: 'user1@mail.com', password: 'qwertyui', name: 'name', id: 6780000)
    question = Question.create!(title: 'notblanc', content: 'notblanc', user_id: 6780000)

    visit new_user_session_path
    fill_in 'Email', with: 'user1@mail.com'
    fill_in 'Password', with: 'qwertyui'
    click_on 'Sign in'

    visit "/questions/#{question[:id]}"
    click_on 'Edit'
    click_on 'Delete'
    expect(page).to have_content("Your question has been deleted")
  end

  scenario 'auth user delete question' do
    User.create!(email: 'user1@mail.com', password: 'qwertyui', name: 'name', id: 6780000)
    User.create!(email: 'user2@mail.com', password: 'qwertyui2', name: 'name2', id: 6780002)

    question = Question.create!(title: 'notblanc', content: 'notblanc', user_id: 6780002)

    visit new_user_session_path
    fill_in 'Email', with: 'user1@mail.com'
    fill_in 'Password', with: 'qwertyui'
    click_on 'Sign in'

    visit "/questions/#{question[:id]}"
    expect(page).to_not have_content("Edit")
  end

  scenario 'non-auth user delete question' do
    User.create!(email: 'user2@mail.com', password: 'qwertyui2', name: 'name2', id: 6780002)
    question = Question.create!(title: 'notblanc', content: 'notblanc', user_id: 6780002)

    visit "/questions/#{question[:id]}"
    expect(page).to_not have_content("Edit")
  end
end
