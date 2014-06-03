require_relative 'acceptance_helper'

feature "user profile" do

  let!(:users) {create_list(:user, 30)}

  before do
    visit root_path
  end

  scenario "non-auth sees user's list" do
    click_on "пользователи"
    expect(page.current_path).to eq users_path
    expect(page).to have_content users.first.email
    click_on "Last"
    expect(page).to have_content users.last.email
  end

  scenario "non-auth visits one's profile" do
    click_on "пользователи"
    click_on users.first.email
    expect(page.current_path).to eq user_path(users.first)
    expect(page).to_not have_content "редактировать/удалить ваш эккаунт"
  end

  describe "auth" do
    let(:user) {create(:user)}

    before do
      sign_in(user)
    end

    scenario "auth sees user's list" do
      click_on "пользователи"
      expect(page.current_path).to eq users_path
      expect(page).to have_content users.first.email
      expect(page).to have_content users.second.email
    end

    scenario "owner visits his profile" do
      click_on "приветствуем, #{user.name}"
      expect(page.current_path).to eq user_path(user)
      expect(page).to have_content "редактировать/удалить ваш эккаунт"
    end

    scenario "owner can edit his profile" do
      click_on "приветствуем, #{user.name}"
      click_on "редактировать/удалить ваш эккаунт"
      expect(page).to have_content "Edit User"
    end

    scenario "owner edits his profile" do
      click_on "приветствуем, #{user.name}"
      click_on "редактировать/удалить ваш эккаунт"
      fill_in 'Name', with: "NAME"
      fill_in 'Current password', with: user.password
      click_on "Update"
      expect(page.current_path).to eq root_path
      expect(page).to have_content "You updated your account successfully."
    end

    scenario "owner can delete his profile" do
      click_on "приветствуем, #{user.name}"
      click_on "редактировать/удалить ваш эккаунт"
      expect(page).to have_content "Cancel my account"
    end

    scenario "owner deletes his profile" do
      click_on "приветствуем, #{user.name}"
      click_on "редактировать/удалить ваш эккаунт"
      click_on "Cancel my account"
      expect(page.current_path).to eq root_path
      expect(page).to have_content "Bye! Your account was successfully cancelled. We hope to see you again soon."
    end
  end
end
