require 'spec_helper'

describe VotesController do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "vote for object" do
    it "plus user vote" do
      expect {
        xhr :post, :create, type: 'question', id: question.id
      }.to change { user.votes.count }.from(0).to(1)
    end
  end

  describe "unvote for object" do
    it "minus user vote" do
      expect {
        xhr :post, :destroy, type: 'question', id: question.id
      }.to change { user.votes.count }.from(0).to(1)
    end
  end
end
