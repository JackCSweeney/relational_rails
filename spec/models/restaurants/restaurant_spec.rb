require 'rails_helper' 

RSpec.describe Restaurant do

  it {should have_many(:cooks)}
  
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

  describe '#sort_by_creation' do
    it 'can sort the restaurants in the order of creation' do
      restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
      sleep 1
      restaurant_2 = Restaurant.create!(name: "Paul's", open: true, dishes: 25)
      sleep 1
      restaurant_3 = Restaurant.create!(name: "Pam's", open: true, dishes: 25)

      expect(Restaurant.sort_by_creation).to eq([restaurant_3, restaurant_2, restaurant_1])
    end
  end

  describe '#self.order_by_cooks'
    it 'can sort restaurants in ascending order by number of cooks' do
      restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
      restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)
      restaurant_3 = Restaurant.create!(name: "Paul's", open: true, dishes: 5)
      cook_1 = restaurant_1.cooks.create!(name: "Doug", serv_safe_certified: true, dishes_known: 13)
      cook_2 = restaurant_1.cooks.create!(name: "Dave", serv_safe_certified: true, dishes_known: 14)
      cook_3 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 15)
      cook_4 = restaurant_2.cooks.create!(name: "Dan 2", serv_safe_certified: true, dishes_known: 15)
      cook_5 = restaurant_3.cooks.create!(name: "Dan 4", serv_safe_certified: true, dishes_known: 15)
      cook_6 = restaurant_3.cooks.create!(name: "Dan 5", serv_safe_certified: true, dishes_known: 15)
      
      expect(Restaurant.order_by_cooks).to eq([restaurant_1, restaurant_3, restaurant_2])
    end
end