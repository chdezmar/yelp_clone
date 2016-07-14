def user_sign_up(email = 'test@test.com', password = 'password', password_confirmation = 'password')
	visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password_confirmation
  click_button 'Sign up'
end

def add_restaurant(name = 'restaurant', description = 'description')
	visit '/'
	click_link 'Add a restaurant'
	fill_in 'Name', with: name
	fill_in 'Description', with: description
	click_button 'Create Restaurant'
end

def sign_in(email = 'test@test.com', password = 'password')
	visit '/'
	click_link 'Sign in'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign in'
end

def sign_out
	visit '/'
	click_link 'Sign out'
end

def review(name, content, rating)
	visit '/restaurants'
	click_link 'Review ' + name
	fill_in "Thoughts", with: content
	select rating, from: 'Rating'
	click_button 'Leave Review'
end
