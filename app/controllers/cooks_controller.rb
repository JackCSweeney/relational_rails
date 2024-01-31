class CooksController < ApplicationController

    def index
        @cooks = Cook.all
    end

    def show
        @cook = Cook.find(params[:id])
    end

end