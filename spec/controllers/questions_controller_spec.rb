require 'spec_helper'

describe QuestionsController do
  let(:question) { create(:question, user: user) }
  let(:user) { create(:user) }
  let(:invalid_question) { create(:invalid_question) }

  describe 'GET #index' do
    let(:questions) {create_list(:question, 2)}

    before {get :index}

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns a new answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do

    before { sign_in user; get :new }

    it 'assigns a new question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, id: question }

    it 'assigns an edit question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do

    before { sign_in user }

    context 'valid attributes' do
      it 'saves the new question to db' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'invalid attributes' do
      it 'does not save the question' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do

    before { sign_in user }

    context 'valid attributes' do

      it 'changes question attributes' do
        patch :update, id: question.id, question: { title: 'new title', content: 'new content'}, format: :js
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.content).to eq('new content')
      end
    end

    context 'invalid attributes' do
      before {patch :update, id: question, question: { title: 'new title', content: nil}, format: :js }

      it 'does not change q attributes' do
        question.reload
        expect(question.title).to eq('notblanc title')
        expect(question.content).to eq "notblanc content"
      end
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in user; question }

    it 'deletes question' do
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end
end
