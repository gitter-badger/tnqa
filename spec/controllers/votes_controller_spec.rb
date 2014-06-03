require 'spec_helper'

describe VotesController do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "vote for object" do
    it "add user vote" do
      expect {
        xhr 'create', type: 'question', id: question.id, up_down: 1
      }.to change { user.votes.count }.from(0).to(1)
    end
  end

  describe "unvote for object" do
    it "remove user vote" do
      user.vote!(question)
      expect {
        xhr 'destroy', type: 'question', id: question.id
      }.to change { user.votes.count }.from(1).to(0)
    end
  end
end
