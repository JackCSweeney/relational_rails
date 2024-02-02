require 'rails_helper'

RSpec.describe Cook do
  it {should belong_to(:restaurant)}

  describe '#serv_safe_certification' do
    it 'returns self if serv safe certified' do
      restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
		  cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)
		  cook_2 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: false, dishes_known: 13, restaurant_id: 1)
      

      expect(cook_1.serv_safe_certification).to eq(cook_1)
      expect(cook_2.serv_safe_certification).to eq(nil)
    end
  end
end