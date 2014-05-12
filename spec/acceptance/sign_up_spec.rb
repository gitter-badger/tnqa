require 'spec_helper'

feature 'Signing up', 'sign up to ask' do

  context "registration" do
    scenario "user can sign up through registration page" do
      visit new_user_registration_path
      fill_in 'Name', with: 'Name'
      fill_in 'Email', with: 'test@test.ru'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button "Sign up"
      expect(page).to have_content "Welcome! You have signed up successfully"
      expect { post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
      expect(response).to redirect_to questions_path
    end
    scenario "user can not sign up with invalid attributes" do
      visit new_user_registration_path
      fill_in 'Name', with: 'Name'
      fill_in 'Email', with: 'test.ru'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button "Sign up"
      expect(page).to have_content "Error"
      expect { post :create, user: attributes_for(:user) }.to_not change(User, :count)
    end

  end

end
