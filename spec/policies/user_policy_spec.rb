require 'spec_helper'
describe UserPolicy do
  let(:user) {create :user}
  subject{UserPolicy.new(user, user)}

  context '#upvote?' do
    it 'is possible to vote if rep >= 15' do
      user.reps.create action_value: 15
      expect(user.reputation).to eq 15
      expect(subject.upvote?).to eq true
    end

    it 'is impossible to vote if rep < 15' do
      expect(user.reputation).to eq 0
      expect(subject.upvote?).to eq false
    end
  end

  context '#downvote?' do
    it 'is possible to downvote if rep >= 125' do
      user.reps.create action_value: 125
      expect(subject.downvote?).to eq true
    end

    it 'is impossible to downvote if rep < 125' do
      expect(subject.downvote?).to eq false
    end
  end
end
