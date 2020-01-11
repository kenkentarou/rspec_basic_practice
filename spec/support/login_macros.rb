module LoginMacros
  def login(user)
    user
    visit login_path
    fill_in 'Email', with: 'a@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end
end
