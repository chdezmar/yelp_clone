require 'rails_helper'

feature 'reviewing' do

  before do
    user_sign_up
    add_restaurant('KFC')
  end

  let!(:kfc) { Restaurant.find_by(name: 'KFC')}

  scenario 'allows users to leave a review using a form' do

     visit '/restaurants'
     click_link 'Review KFC'
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'
     click_link 'KFC'

     expect(current_path).to eq "/restaurants/#{kfc.id}"
     expect(page).to have_content('so so')
  end

  scenario 'reviews are shown on the homepage' do
    review('KFC','so so', '3')
    expect(page).to have_content('so so')
  end

  scenario 'does not allow users to review the same restaurant twice' do
    review('KFC','so so', '3')
    review('KFC','so so', '3')
    expect(page).to have_content('You have already reviewed this restaurant')
  end

  xscenario 'users can delete only their own reviews' do
    visit '/'
    review('KFC','so so', '3')
    click_link 'Sign out'
    user_sign_up("user2@user.com","password","password")
    expect(page).not_to have_link 'Delete Review'
  end



  scenario 'displays an average rating for all reviews' do
    review('KFC','So so', '3')
    sign_out
    user_sign_up('test1@gmail.com','lolololol','lolololol')
    review('KFC','Great', '5')
    expect(page).to have_content('Average rating: 4')
  end


end
