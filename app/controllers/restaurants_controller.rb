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

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    restaurant = Restaurant.find(params[:id])
    restaurant.update({
      name: params[:name],
      open: params[:open],
      dishes: params[:dishes]
    })
    restaurant.save
    redirect_to "/restaurants/#{restaurant.id}"
  end

end