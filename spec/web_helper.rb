def user_sign_up
	visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'testest'
  fill_in 'Password confirmation', with: 'testest'
  click_button 'Sign up'
end
