require_relative 'acceptance_helper'

feature 'Voting', 'ability to change question votes' do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:vote) { create(:vote, question: question) }

  scenario 'Auth user adds vote', js: true  do
    sign_in(user2)

    visit question_path(question)
    within "#vote-#{question.vote.id}" do
      click_on 'ЗА'

      within "#vote-#{question.vote.id}-count" do
        expect(page).to have_content  vote_add
      end
    end
  end

  scenario 'Auth user subtracts vote', js: true do
    sign_in(user2)

    visit question_path(question)
    within "#vote-#{question.vote.id}" do
      click_on 'ПРОТИВ'

      within "#vote-#{question.vote.id}-count" do
        expect(page).to have_content  vote_substract
      end
    end
  end

  scenario 'owner adds vote', js: true  do
    sign_in(user)

    visit question_path(question)
    within "#vote-#{question.vote.id}" do
      click_on 'ЗА'

      within "#vote-#{question.vote.id}-count" do
        expect(page).to have_content  error
      end
    end
  end

  scenario 'owner subtracts vote', js: true do
    sign_in(user)

    visit question_path(question)
    within "#vote-#{question.vote.id}" do
      click_on 'ПРОТИВ'

      within "#vote-#{question.vote.id}-count" do
        expect(page).to have_content  error
      end
    end
  end

  scenario 'Non-auth user tries to up vote' do
    visit question_path(question)
    within "#vote-#{question.vote.id}" do
      click_on 'ЗА'
    end
    expect(page).to have_content %q(You need to sign in
                                    or sign up before continuing.)
  end

  scenario 'Non-auth user tries to down vote' do
    visit question_path(question)
    within "#vote-#{question.vote.id}" do
      click_on 'ПРОТИВ'
    end
    expect(page).to have_content %q(You need to sign in
                                    or sign up before continuing.)
  end
end
