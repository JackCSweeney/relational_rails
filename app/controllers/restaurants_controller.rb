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
    if params[:sort] == "name"
      @cooks = show.find_cooks.sort_by {|cook| cook.name}
    elsif params[:search] != nil
      @cooks = show.find_cooks.find_all {|cook| cook.dishes_known >= params[:search].to_i}
    else
      @cooks = show.find_cooks
    end
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

  def destroy
    Cook.destroy(Cook.cook_ids(cooks))
    Restaurant.destroy(params[:id])
    redirect_to "/restaurants"
  end

end