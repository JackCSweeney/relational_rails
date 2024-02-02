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
    cook = @restaurant.cooks.new({
        name: params[:name],
        serv_safe_certified: params[:serv_safe_certified],
        dishes_known: params[:dishes_known]
    })
    cook.save 
    redirect_to "/restaurants/#{@restaurant.id}/cooks"
  end

  def edit
    @cook = Cook.find(params[:id])
  end

  def update
    cook = Cook.find(params[:id])
    cook.update({
      name: params[:name],
      serv_safe_certified: params[:serv_safe_certified],
      dishes_known: params[:dishes_known]
    })
    cook.save
    redirect_to "/cooks/#{cook.id}"
  end
  
end