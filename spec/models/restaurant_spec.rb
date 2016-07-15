require 'spec_helper'
require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it { should validate_uniqueness_of(:name) }

  context '1 review' do
    it 'returns that rating' do
      User.create!(id: 1, email: 'lol@gmail.com', password: 'lololol')
      restaurant = Restaurant.create!(name: 'The Ivy', user_id: 1)
      restaurant.reviews.create!(rating: 4, user_id: 1)
      expect(restaurant.average_rating).to eq 4
    end
  end

  context 'multiple reviews' do
    it 'returns the average' do
      User.create!(id: 1, email: 'lol@gmail.com', password: 'lololol')
      User.create!(id: 2, email: 'lolol@gmail.com', password: 'lololol')
      User.create!(id: 3, email: 'lololol@gmail.com', password: 'lololol')
      restaurant = Restaurant.create!(name: 'The Ivy', user_id: 1)
      restaurant.reviews.create!(rating: 1, user_id: 3)
      restaurant.reviews.create!(rating: 5, user_id: 2)
      expect(restaurant.average_rating).to eq 3
    end
  end


end
