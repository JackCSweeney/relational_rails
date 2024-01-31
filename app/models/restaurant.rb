class Restaurant < ApplicationRecord

    def find_cooks
        Cook.all.find_all do |cook|
            cook.restaurant_id == self.id
        end
    end


end