require 'spec_helper'

feature 'update question', 'to correct info I want to update question' do
      
   scenario 'owner update question' do
     User.create!(email: 'user1@mail.com', password: 'qwertyui', name: 'name', id: 6780000)
    question = Question.create!(title: 'notblanc', content: 'notblanc', user_id: 6780000)

    visit new_user_session_path
    fill_in 'Email', with: 'user1@mail.com'
    fill_in 'Password', with: 'qwertyui'
    click_on 'Sign in'

      #visit "/questions/#{question[:id]}"
      visit edit_question_path(question)
      fill_in("Title", with: "My Title")
      fill_in("Content", with: 'My Body')
      click_button 'Update'
    #expect(assigns(:question)).to have(title: "My Title", content: 'My Body')
    expect(page).to have_content("Your question has been updated")
  end

  scenario 'auth user update question' do
    User.create!(email: 'user1@mail.com', password: 'qwertyui', name: 'name')

end

  scenario 'non-auth user update question' do
    # visit '/question'
    # click_on 'Update question'

    # expect(page).to have_content "You need to sign in or sign up before continuing."

  end
end