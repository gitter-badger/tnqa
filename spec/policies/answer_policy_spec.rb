require "spec_helper"

describe AnswerPolicy do
  let(:user) { create(:user) }
  let(:record) { create :answer, user: user }

  context '#create?' do
    it 'is false if user nil' do
      expect(AnswerPolicy.new(nil, record).create?).to eq(false)
    end
    it 'is true if user exists' do
      expect(AnswerPolicy.new(user, record).create?).to eq(true)
    end
  end

  context '#update?' do
    it 'is false if user non-author' do 
      user = create(:user)
      expect(AnswerPolicy.new(user, record).update?).to eq(false)
    end

    it 'is true if user is author' do
      expect(AnswerPolicy.new(user, record).update?).to eq(true)
    end
  end

  context '#destroy?' do
    it 'is false if user non-author' do 
      user = create(:user)
      expect(AnswerPolicy.new(user, record).destroy?).to eq(false)
    end

    it 'is true if user is author' do
      expect(AnswerPolicy.new(user, record).destroy?).to eq(true)
    end
  end
end
