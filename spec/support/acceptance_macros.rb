module AcceptanceMacros

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'
  end

  def sign_up
    fill_in 'Name', with: 'Name'
    fill_in 'Email', with: 'test@test.ru'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button "Sign up"
  end

  def not_sign_up
    fill_in 'Name', with: 'Name'
    fill_in 'Email', with: 'test.ru'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button "Sign up"
  end

  def plus_v
    (vote.quantity + 1).to_s
  end

  def minus_v
    (vote.quantity - 1).to_s
  end
end
