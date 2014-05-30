require_relative 'acceptance_helper'

feature 'Voting', 'ability to change question votes' do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:vote) { create(:vote, question: question, user: user2) }

  scenario 'Auth user adds vote', js: true  do
    sign_in(user2)
    visit root_path
    within "#question-#{question.id}" do
      click_on "#{vote_path_for(object)}&up_down=1"
      within "#question-#{question.id}" do
        expect(page).to have_content  vote_add
      end
    end
  end

  scenario 'Auth user subtracts vote', js: true do
    sign_in(user2)
    visit root_path
    within within "#question-#{question.id}" do
      click_on "#{vote_path_for(object)}&up_down=-1"
      within within "#question-#{question.id}" do
        expect(page).to have_content  vote_substract
      end
    end
  end

  scenario 'owner adds vote', js: true  do
    sign_in(user)
    visit root_path
    within "#question-#{question.id}" do
      click_on 
      within "#question-#{question.id}" do
        expect(page).to have_content  vote_add
      end
    end
  end

  scenario 'owner subtracts vote', js: true do
    sign_in(user)
    visit root_path
    within "#question-#{question.id}" do
      click_on 
      within "#question-#{question.id}" do
        expect(page).to have_content  vote_substract
      end
    end
  end

  scenario 'Non-auth user tries to up vote' do
    visit root_path
    within "#question-#{question.id}" do
      click_on 
    end
    expect(page).to have_content %q(You need to sign in
                                    or sign up before continuing.)
  end

  scenario 'Non-auth user tries to down vote' do
    visit root_path
    within "#question-#{question.id}" do
      click_on 
    end
    expect(page).to have_content %q(You need to sign in
                                    or sign up before continuing.)
  end
end
