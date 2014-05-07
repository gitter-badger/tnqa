require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }
  let(:invalid_user) { create(:invalid_user) }


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

  describe 'GET #show' do
    before { get :show, id: user }

    it 'assigns the requested user to @user' do
      expect(assigns(:user)).to eq user
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do

    before { get :new }

    it 'assigns a new user to @user' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do

    context 'valid user attributes' do
      it 'saves the new user to db' do
        expect { post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to users_path
      end
    end

    context 'invalid user attributes' do
      it 'does not save the user' do
        expect { post :create, user: attributes_for(:invalid_user) }.to_not change(User, :count)
      end

      it 're-renders new view' do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end

    describe 'PATCH #update' do

      before { sign_in user }

      context 'valid attributes' do
        it "assigns the requested user to @user" do
          patch :update, id: user, user: attributes_for(:user)
          expect(assigns(:user)).to eq user
        end

        it 'changes user attributes' do
          patch :update, id: user, user: { name: 'new name' }
          user.reload
          expect(user.name).to eq 'new name'
        end

        it 'redirects to the updated user' do
          patch :update, id: user, user: attributes_for(:user)
          expect(response).to redirect_to user
        end
      end

      context 'invalid attributes' do
        before {patch :update, id: user, user: { name: nil } }

        it 'does not change q attributes' do
          user.reload
          expect(user.name).to_not eq nil
        end

        it "re-renders edit view" do
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      before { sign_in user }

      it 'delete user' do
        expect { delete :destroy, id: user }.to change(User, :count).by(-1)
      end

      it 'redirect to index view' do
        delete :destroy, id: user
        expect(response).to redirect_to users_path
      end
    end
  end
end
