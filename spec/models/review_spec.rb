require 'rails_helper'

describe Review, type: :helper do
	it "is invalid if the rating is more than 5" do
		review = Review.new(rating: 10)
		expect(review).to have(1).error_on(:rating)
	end

	it 'returns five black stars for five' do
	  expect(helper.star_rating(5)).to eq '★★★★★'
	end

	it 'returns three black stars and two white stars for three' do
  	expect(helper.star_rating(3)).to eq '★★★☆☆'
	end

	it 'returns four black stars and one white star for 3.5' do
  	expect(helper.star_rating(3.5)).to eq '★★★★☆'
	end


end
