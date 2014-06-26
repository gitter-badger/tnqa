require "spec_helper"

describe ApplicationHelper do
  let(:user) {create :user}

  context '#avatar' do

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

  context '#favorite_for' do
    let(:question) {create :question}
    before { helper.stub(current_user: user) }

    it 'has minus if favorite' do
      user.favorite! question
      expect(helper.favorite_for(question)).to match("minus")
    end

    it 'has plus if nonfavorite' do
      expect(helper.favorite_for(question)).to match("plus")
    end
  end
end
