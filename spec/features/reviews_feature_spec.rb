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

     visit '/restaurants'
     click_link 'Review KFC'
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'
     expect(page).to have_content('so so')
  end



end
