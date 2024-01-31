require 'rails_helper'

RSpec.describe 'the individual restaurant page' do
    it 'shows the specific restaurant and all of its attributes' do
        restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
        restaurant_2 = Restaurant.create!(name: "Pam's", open: false, dishes: 6)

        visit "/restaurants/#{restaurant_1.id}"

        expect(page).to have_content(restaurant_1.name)
        expect(page).to have_content(restaurant_1.open)
        expect(page).to have_content(restaurant_1.dishes)
        expect(page).to have_content(restaurant_1.created_at)
        expect(page).to have_content(restaurant_1.updated_at)
        expect(page).not_to have_content(restaurant_2.name)
    end
end