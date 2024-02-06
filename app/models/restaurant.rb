class Restaurant < ApplicationRecord
    has_many :cooks
    def find_cooks
        Cook.where("restaurant_id = #{self.id}")
    end

    def cook_count
        find_cooks.count
    end

    def self.sort_by_creation
        order(created_at: :desc)
    end
end