require 'spec_helper'

feature 'create question', 'to qet answer being auth. I want to ask' do

let(:user) {create(:user)}

  scenario 'auth user create q' do
    sign_in(user)

    visit root_path
    click_on 'Ask question'
    fill_in 'Title', with: 'my title'
    fill_in 'Content', with: 'my content'
    click_on 'create'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'non-auth user create q' do
    visit '/questions'
    expect(page).to_not have_content("Ask question")
  end
end
