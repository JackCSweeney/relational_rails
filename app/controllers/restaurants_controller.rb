class RestaurantsController < ApplicationController
  def index
      @restaurants = Restaurant.all
  end
  
  def new
  end

  def create
    restaurant = Restaurant.new({
      name: params[:name],
      open: params[:open],
      dishes: params[:dishes]
    })
    restaurant.save
    redirect_to "/restaurants"
  end

  def show
      @restaurant = Restaurant.find(params[:id])
  end
      
  def cooks
      @cooks = show.find_cooks
  end

end