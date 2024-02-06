class CooksController < ApplicationController

  def index
    @cooks = Cook.all
  end

  def show
    @cook = Cook.find(params[:id])
  end

  def new
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.find(params[:id])
    cook = @restaurant.cooks.new(cook_params)
    cook.save 
    redirect_to "/restaurants/#{@restaurant.id}/cooks"
  end

  def edit
    @cook = Cook.find(params[:id])
  end

  def update
    cook = Cook.find(params[:id])
    cook.update(cook_params)
    cook.save
    redirect_to "/cooks/#{cook.id}"
  end

  def destroy
    Cook.destroy(params[:id])
    redirect_to "/cooks"
  end

private
  def cook_params
    params.permit(:name, :serv_safe_certified, :dishes_known)
  end
  
end