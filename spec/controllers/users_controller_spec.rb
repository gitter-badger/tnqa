require 'spec_helper'

describe UsersController do
 let(:user) { create(:user) }

describe 'GET #index' do
    let(:users) {create_list(:user, 2)}

    before {get :index}

    it 'populates an array of all users' do
      expect(assigns(:users)).to match_array(@users)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

describe 'GET #new' do

    before { get :new }
      #User.create!(email: 'user@mail.com', password: 'qwertyui', name: 'name'); get :new }

    it 'assigns a new question to @question' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

# describe 'POST #create' do
#     context 'valid attributes' do
#       it 'saves the new user to db' do
#         expect { post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
#       end

#       it 'redirects to show view' do
#         post :create, user: attributes_for(:user)
#         expect(response).to redirect_to question_path(assigns(:user))
#       end
#     end

#     # context 'invalid attributes' do
#     #   it 'does not save the question' do
#     #     expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
#     #   end

#     #   it 're-renders new view' do
#     #     post :create, question: attributes_for(:invalid_question)
#     #     expect(response).to render_template :new
#     #   end
#     #  end
#     end

end
