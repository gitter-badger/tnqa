require 'spec_helper'

feature 'update question', 'to correct info I want to update question' do

  scenario 'owner update question' do
    User.create!(email: 'user1@mail.com', password: 'qwertyui', name: 'name', id: 6780000)
    question = Question.create!(title: 'notblanc', content: 'notblanc', user_id: 6780000)

    visit new_user_session_path
    fill_in 'Email', with: 'user1@mail.com'
    fill_in 'Password', with: 'qwertyui'
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

  scenario 'non-auth user update question' do
    #User.create!(email: 'user2@mail.com', password: 'qwertyui2', name: 'name2', id: 6780002)
    question = Question.create!(title: 'notblanc', content: 'notblanc', user_id: 6780002)

    visit "/questions/#{question[:id]}"
    expect(page).to_not have_content("Edit")
  end
end
