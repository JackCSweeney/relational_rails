class CooksController < ApplicationController

    def index
        @cooks = Cook.all
    end

end