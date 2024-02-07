class RestaurantsController < ApplicationController
  def index
    if params[:sort] == "cook_count"
      @restaurants = Restaurant.order_by_cooks
    else
      @restaurants = Restaurant.sort_by_creation
    end
  end
  
  def new
  end

  def create
    restaurant = Restaurant.new(restaurant_params)
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
    restaurant.update(restaurant_params)
    restaurant.save
    redirect_to "/restaurants/#{restaurant.id}"
  end

  def destroy
    Cook.destroy(Cook.cook_ids(cooks))
    Restaurant.destroy(params[:id])
    redirect_to "/restaurants"
  end

private
  def restaurant_params
    params.permit(:name, :open, :dishes)
  end

  # some of the logic from the index methods could potentially be captured here in the private methods to keep things restful/utilizing CRUD

end