require 'spec_helper'

feature 'create question', 'to qet answer being auth. I want to ask' do

let(:user) {create(:user)}

  scenario 'auth user create q' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'

    visit '/questions'
    click_on 'Ask question'
    fill_in 'Title', with: 'my title'
    fill_in 'Content', with: 'my content'
    click_on 'create'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'non-auth user create q' do
    visit '/questions'
    click_on 'Ask question'

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end
