require_relative 'acceptance_helper'

feature 'Signing in', 'log in to ask' do

 let(:user) {create(:user)}

  scenario 'Existing user try to log in' do
    sign_in(user)
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Existing user try to log in with invalid password' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'invalidpassword'
    click_on 'Sign in'
    expect(page).to have_content 'Invalid email or password.'
  end

  scenario 'Non-existing user try to log in' do
    visit new_user_session_path
    fill_in 'Email', with: 'invalid@user.com'
    fill_in 'Password', with: 'invalidpassword'
    click_on 'Sign in'
    expect(page).to have_content 'Invalid email or password.'
  end
end
