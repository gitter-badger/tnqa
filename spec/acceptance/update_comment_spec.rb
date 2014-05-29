# require_relative 'acceptance_helper'

# feature 'update comment for answer', 'updating comment' do

#   let(:user) { create(:user) }
#   let(:user2) { create(:user) }
#   let(:question) { create(:question, user: user) }
#   let(:answer) { create(:answer, question: question, user: user) }
#   let(:comment) { create(:comment, commentable: answer, user: user) }
#   let(:comment2) { create(:comment, commentable: answer, user: user2) }

#   scenario 'non-auth user try to destroy comment' do
#     visit question_path(question)

#     within "#comment_#{comment.id}" do
#       expect(page).to_not have_link 'Edit'
#     end
#   end

#   describe 'auth user' do
#     background do
#       sign_in(user)
#       visit question_path(question)
#     end

#     scenario 'owner sees link to update comment' do
#       within "#comment_#{comment.id}" do
#         expect(page).to have_link 'Edit'
#       end
#     end

#     scenario 'owner update his comment', js: true do
#       within "#comment_#{comment.id}" do
#         click_on 'Edit'
#         fill_in "Comment", with: "editing comment"
#         click_on "Save"


#         expect(current_path).to eq question_path(question)
#         expect(page).not_to have_content comment.content
#         expect(page).to have_content 'editing comment'
#         expect(page).to_not have_selector 'textarea'
#       end
#     end

#     scenario 'other user try to destroy comment', js: true do
#       within "#comment_#{comment2.id}" do
#         expect(page).to_not have_link 'Edit'
#       end
#     end
#   end
# end
