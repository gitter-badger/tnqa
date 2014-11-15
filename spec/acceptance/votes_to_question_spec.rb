require_relative 'acceptance_helper'

feature 'Voting', 'ability to change question votes' do
  let(:user) { create(:user, :with_reputation) }
  let(:user2) { create(:user, :with_reputation) }
  let!(:question) { create(:question, user: user) }
  let(:vote) { create(:vote, votable: question, user: user2) }

  def get_vote(page, question)
    page.find("#question_#{question.id} h3.value").text.to_i
  end

  scenario 'Auth user adds vote', js: true  do
    sign_in(user2)
    visit root_path
    within "#question_#{question.id}" do
      expect{
        page.find(".glyphicon-thumbs-up").click
        sleep 2
      }.to change{get_vote(page, question)}.by(1)
    end
  end

  scenario 'Auth user subtracts vote', js: true do
    sign_in(user2)
    visit root_path
    within "#question_#{question.id}" do
      expect{
        page.find(".glyphicon-thumbs-down").click
        sleep 2
      }.to change{get_vote(page, question)}.by(-1)
    end
  end

  scenario 'owner adds vote', js: true  do
    sign_in(user)
    visit root_path
    within "#question_#{question.id}" do
      expect{
        page.find(".glyphicon-thumbs-up").click
        sleep 2
    }.to change{get_vote(page, question)}.by(1)    end
  end

  scenario 'owner subtracts vote', js: true do
    sign_in(user)
    visit root_path
    within "#question_#{question.id}" do
      expect{
        page.find(".glyphicon-thumbs-down").click
        sleep 2
    }.to change{get_vote(page, question)}.by(-1)    end
  end

  scenario 'Non-auth user tries to up vote', js: true do
    visit root_path
    within "#question_#{question.id}" do
      expect(page).to_not have_content ".glyphicon-thumbs-up"
    end
  end

  scenario 'Non-auth user tries to down vote', js: true do
    visit root_path
    within "#question_#{question.id}" do
      expect(page).to_not have_content ".glyphicon-thumbs-down"
    end
  end
end
