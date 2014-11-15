require 'spec_helper'

describe User do

  #it { should validate_presence_of :name }
  #it { should ensure_length_of(:name).is_at_least(3).is_at_most(200) }
  it { should have_many(:questions) }
  it { should have_many(:answers) }

  describe ".find_for_oauth" do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '12345678') }

    context 'user already has authorization' do
      it 'returns the user' do
        user.authorizations.create(provider: 'facebook', uid: '12345678')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do
      context 'user already exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }
        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorization for user' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'user does not exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new@user.com' }) }

        it 'creates new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end

        it 'returns new user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end

        it 'fills user email' do
          user = User.find_for_oauth(auth)
          expect(user.email).to eq auth.info[:email]
        end

        it 'creates authorization for user' do
          user = User.find_for_oauth(auth)
          expect(user.authorizations).to_not be_empty
        end

        it 'creates authorization with provider, uid, checksum' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
      end
    end
  end

  context 'reputation' do
    let(:user) { create(:user) }

    it 'returns 0 by default' do
      expect(user.reputation).to eq 0
    end

    it 'returns sum of all action_values' do
      create_list(:rep, 2, user: user, action_value: 5, action_name: :vote)
      expect(user.reputation).to eq 10
    end

    it 'creates new rep and returns 5' do
      question = create(:question)
      expect { user.vote!(question) }.to change{ question.user.reputation }.by(5)
    end

    it 'creates new rep and returns -2' do
      question = create(:question)
      expect { user.unvote!(question) }.to change{ question.user.reputation }.by(-2)
    end

    it 'creates new rep and returns 10' do
      answer = create(:answer)
      expect { user.vote!(answer) }.to change{ answer.user.reputation }.by(10  )
    end

    it 'creates new rep and returns -2' do
      answer = create(:answer)
      expect { user.unvote!(answer) }.to change{ answer.user.reputation }.by(-2)
    end
  end
end
