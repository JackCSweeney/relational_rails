require 'rails_helper'

RSpec.describe 'the restaurants index page' do
    it 'can list the restaurants in the system' do
        restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
        restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)

        visit "/restaurants"

        expect(page).to have_content(restaurant_1.name)
        expect(page).to have_content(restaurant_2.name)
    end
end