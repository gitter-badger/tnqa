require 'spec_helper'

feature 'update question', 'to correct info I want to update question' do
      
  scenario 'owner update question' do
    User.create!(email: 'user1@mail.com', password: 'qwertyui', name: 'name')


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