require "spec_helper"

describe ApplicationHelper do 
  context '#avatar' do
  	let(:user) {create :user}

    it 'returns nothing if user nil' do 
      expect(helper.avatar(nil)).to be_empty
    end

    it 'returns link to user profile' do
      expect(helper.avatar(user)).to match(user_path(user))
    end

    it 'returns avatar image' do
      expect(helper.avatar(user)).to match("<img")
    end
  end
end 

