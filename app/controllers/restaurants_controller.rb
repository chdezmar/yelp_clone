class RestaurantsController < ApplicationController
	def index
		@resturants = Restaurant.all
	end

end
