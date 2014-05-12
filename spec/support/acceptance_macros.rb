module AcceptanceMacros

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'
  end

  def sign_up(user)
    fill_in 'Name', with: 'Name'
    fill_in 'Email', with: 'test.ru'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button "Sign up"
  end

  def not_sign_up(user)
        fill_in 'Name', with: 'Name'
        fill_in 'Email', with: 'test.ru'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button "Sign up"
  end

end
