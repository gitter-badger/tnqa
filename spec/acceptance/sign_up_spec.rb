require 'spec_helper'

feature 'Signing up', 'sign up to ask' do

  let(:user) {  create :user }

  describe "registration" do

    context "valid attributes" do
      scenario "user can sign up through registration page" do
        visit new_user_registration_path
        sign_up(user)
        expect(page).to have_content "Welcome! You have signed up successfully"
        #expect(response).to redirect_to questions_path
      end

      scenario 'new user is created' do
        expect do
          visit new_user_registration_path
          sign_up(user)
        end.to change(User, :count).by(1)
      end

      scenario 'new user is created' do
          visit new_user_registration_path
          sign_up(user)
          expect(current_url).to eq(users_url)
      end

    end

    context "invalid attributes" do
      scenario "user can not sign up with invalid attributes" do
        visit new_user_registration_path
        not_sign_up(user)
        expect(page).to have_content "Email is invalid"
      end

      scenario 'new user is not created' do
      	expect do
        visit new_user_registration_path
        not_sign_up(user)
      end.to_not change(User, :count)
    end
  end

  scenario 'existing user try to sign in' do

    visit new_user_registration_path
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_on 'Sign up'

    expect(page).to have_content "prohibited this user from being saved"
  end

end
end
