require_relative 'acceptance_helper'
include ActionView::RecordIdentifier

feature 'Сreate comments', 'commenting answers and questions', js: true do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user ) }
  let(:answer) { create(:answer, question: question, user: user) }

  describe 'auth user try to comment' do
    background do
      answer
      sign_in user
      visit question_path(question)
    end

    describe "comment for answer" do

      scenario 'sees form to create comment' do
        within "#answer_#{answer.id}" do
          click_on "+ коммент"
          expect(page).to have_selector 'textarea#comment_content'
        end
      end

      scenario 'comment with valid data', js: true do
        within "#answer_#{answer.id}" do
          click_on "+ коммент"
          fill_in 'ваш комментарий', with: 'My answer comment'
          click_on 'Добавьте комментарий'
        end

        expect(current_path).to eq question_path(question)
        within "#answer_#{answer.id} .comments" do
          expect(page).to have_content 'My answer comment'
        end
      end

      scenario 'comment with invalid data', js: true do
        within "#answer_#{answer.id}" do
          click_on "+ коммент"
          fill_in 'ваш комментарий', with: ''
          click_on 'Добавьте комментарий'
        end

        expect(current_path).to eq question_path(question)
        within "#answer_#{answer.id} form#comments_" + dom_id(answer) do
          expect(page).to have_content "Content can't be blank"
        end
      end
    end

  #   describe "comment for question" do

  #     scenario 'sees form to create comment' do
  #       within ".question" do
  #         click_on "+ коммент"
  #         expect(page).to have_selector 'textarea#comment_content'
  #       end
  #     end

  #     scenario 'comment with valid data', js: true do
  #       within "#comments_" + dom_id(question) do
  #         fill_in 'Your comment', with: 'My comment'
  #         click_on 'Post Your Comment'
  #       end

  #       expect(current_path).to eq question_path(question)
  #       within '.question .comments' do
  #         expect(page).to have_content 'My comment'
  #       end
  #       within '.question form#new_comment' do
  #         expect(page).to_not have_content 'My comment'
  #       end
  #     end

  #     scenario 'comment with invalid data', js: true do
  #       within '.question' do
  #         fill_in 'Your comment', with: ''
  #         click_on 'Post Your Comment'
  #       end

  #       expect(current_path).to eq question_path(question)
  #       within ".question form#new_comment" do
  #         expect(page).to have_content "Content can't be blank"
  #       end
  #     end
  #   end
  end

  scenario "non-auth user tries comment" do
    visit question_path(question)
    expect(page).to_not have_content '+ коммент'
  end
end
