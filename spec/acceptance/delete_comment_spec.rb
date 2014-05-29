require_relative 'acceptance_helper'

feature 'delete comment for question', 'deleting comments', js: true do

  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:question) { create(:question, user: user) }
  let!(:comment) { create(:comment, commentable: question, user: user) }

  scenario 'non-auth user try to destroy comment' do
    visit question_path(question)
    
    within "#comment_#{comment.id}" do
      expect(page).to_not have_link "- коммент"
    end
  end

  scenario 'other user try to destroy comment', js: true do
    sign_in(user2)
    visit question_path(question)

    within "#comment_#{comment.id}" do
      expect(page).to_not have_link "- коммент"
    end
  end

  describe 'auth user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'owner sees link to destroy comment' do
      within "#comment_#{comment.id}" do
        expect(page).to have_link "- коммент"
      end
    end

    scenario 'owner destroy his comment', js: true do
      within "#comment_#{comment.id}" do
        click_on "- коммент"

        expect(current_path).to eq question_path(question)
      end
        expect(page).to_not have_selector "#comment_#{comment.id}"
    end
  end
end
