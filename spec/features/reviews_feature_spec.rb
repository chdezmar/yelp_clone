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



end
