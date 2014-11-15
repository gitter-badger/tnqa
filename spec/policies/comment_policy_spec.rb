require "spec_helper"

describe CommentPolicy do
  let(:user) { create(:user) }
  let(:record) { create :comment, user: user }

  context '#create?' do
    it 'is false if user nil' do
      expect(described_class.new(nil, record).create?).to eq(false)
    end
    it 'is true if user exists and rep >= 50' do
      user.reps.create action_value: 50
      expect(described_class.new(user, record).create?).to eq(true)
    end
    it 'is false if user exists and rep < 50' do
      user.reps.create action_value: 5
      expect(described_class.new(user, record).create?).to eq(false)
    end
  end

  context '#update?' do
    it 'is false if user non-author' do
      user = create(:user)
      expect(described_class.new(user, record).update?).to eq(false)
    end

    it 'is true if user is author' do
      expect(described_class.new(user, record).update?).to eq(true)
    end
  end

  context '#destroy?' do
    it 'is false if user non-author' do
      user = create(:user)
      expect(described_class.new(user, record).destroy?).to eq(false)
    end

    it 'is true if user is author' do
      expect(described_class.new(user, record).destroy?).to eq(true)
    end
  end
end
