require 'spec_helper'

feature 'Signing in', 'log in to ask' do

 let(:user) {create(:user)}

  scenario 'Existing user try to log in' do
    sign_in(user)
    click_on "Sign out"
    expect(page.current_path).to eq root_path
  end
 end
