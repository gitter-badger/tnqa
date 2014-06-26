require 'spec_helper'

describe AnswersController do
  let(:question) {create(:question, user: user)}

  let(:user) { create :user, :with_reputation }
  let(:user2) { create :user }

  let(:answer) { create(:answer, question: question, user: user) }
  let(:answer2) { create(:answer, question: question, user: user2) }

  before do
    sign_in(user)
  end

  describe 'POST #create' do

    context 'valid attributes' do
      it 'saves answer' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, format: :js }.to change(question.answers, :count).by(1)
      end

      it 'render create' do
        post :create, answer: attributes_for(:answer), question_id: question, format: :js
        expect(response).to render_template :create
      end
    end

    context 'invalid attributes' do
      it 'does not save' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js }.to_not change(Answer, :count)
      end

      it 'render create' do
        post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do

    it 'assings the requested answer to @answer' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'assings to question' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:question)).to eq question
    end

    it 'no changes answer attributes' do
      patch :update, id: answer2, question_id: question, user_id: user, answer: { content: 'new body'}, format: :js
      #expect { patch :update, id: answer2, question_id: question, user_id: user, answer: { content: 'new body'}, format: :js }.to_not change(Answer, content)
      answer.reload
      expect(answer.content).to eq 'smart answer'
    end

    it 'changes answer attributes' do
      patch :update, id: answer, question_id: question, user_id: user, answer: { content: 'new body'}, format: :js
      answer.reload
      expect(answer.content).to eq 'new body'
    end
  end
end
