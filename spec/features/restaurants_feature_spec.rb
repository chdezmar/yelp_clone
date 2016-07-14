require 'rails_helper'

feature 'Restaurants' do

  context 'Logged in user' do
    before do
      user_sign_up
    end

    context 'no restaurants have been added' do
      scenario 'should display a prompt to add a restaurant' do
        visit '/'
        expect(page).to have_content 'No restaurants yet'
        expect(page).to have_link 'Add a restaurant'
      end
    end

    context 'restaurants have been added' do
      before do
        add_restaurant('KFC')
      end
      scenario 'display restaurants' do
        visit '/'
        expect(page).to have_content 'KFC'
        expect(page).to_not have_content 'No restaurants yet'
      end
    end

    context 'creating restaurants' do
      scenario 'prompts user to fill out a form, then displays the new restaurant' do
        add_restaurant
        expect(current_path).to eq '/restaurants'
      end

      context 'an invalid restaurant' do
        it 'does not let you submit a name that is too short' do
          add_restaurant('kf')
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page).to have_content 'error'
        end
      end
    end

    context 'editing restaurants' do

      scenario 'user cannot edit a restaurant that they did not create' do
        visit '/'
        add_restaurant
        click_link 'Sign out'
        user_sign_up("user2@user.com","password","password")
        expect(page).not_to have_link 'Edit KFC'
        expect(page).not_to have_link 'Delete KFC'
      end

      # before {Restaurant.create name: 'KFC', description: 'Deep fried goodness'}

      scenario 'let a user edit a restaurant' do
        visit '/'
        add_restaurant('KFC', 'Deep fried goodness')
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        fill_in 'Description', with: 'Deep fried goodness'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(current_path).to eq '/restaurants'
      end
    end

    context 'deleting restaurants' do
      scenario 'removes a restaurant when the user clicks a delete link' do
        add_restaurant('KFC')
        visit '/'
        click_link 'Delete KFC'
        expect(page).not_to have_content('KFC')
        expect(page).to have_content('Restaurant deleted successfully')
      end
    end
  end

  context 'Not logged in user' do

    before do
      user_sign_up
      add_restaurant('KFC')
      sign_out
    end
    it 'cannot add a restaurant when not logged in' do
      visit '/'
      expect(page).not_to have_link 'Add a restaurant'
    end

    context 'viewing restaurants' do
      let!(:kfc) { Restaurant.find_by(name: 'KFC')}
      scenario 'let a user view a restaurant' do
        visit '/'
        click_link 'KFC'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq "/restaurants/#{kfc.id}"
      end
    end
  end



end
