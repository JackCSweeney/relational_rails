require 'rails_helper' 

RSpec.describe Restaurant do
  describe '#find_cooks' do  
    it 'can find all cooks based on a restaurant id' do
      restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
      cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)
      cook_2 = restaurant_1.cooks.create!(name: "Dan 2", serv_safe_certified: true, dishes_known: 14, restaurant_id: 1)
      cook_3 = restaurant_1.cooks.create!(name: "Dan 3", serv_safe_certified: true, dishes_known: 15, restaurant_id: 1)

      expected = [cook_1, cook_2, cook_3]

      expect(restaurant_1.find_cooks).to eq(expected)
    end
  end

  describe '#cook_count' do
    it 'can count all cooks based on a restaurant id' do
      restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
      cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)
      cook_2 = restaurant_1.cooks.create!(name: "Dan 2", serv_safe_certified: true, dishes_known: 14, restaurant_id: 1)
      cook_3 = restaurant_1.cooks.create!(name: "Dan 3", serv_safe_certified: true, dishes_known: 15, restaurant_id: 1)

      expect(restaurant_1.cook_count).to eq(3)
    end
  end
end