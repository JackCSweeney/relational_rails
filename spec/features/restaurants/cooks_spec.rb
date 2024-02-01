require 'rails_helper'

RSpec.describe 'the restaurants/:id/cooks page' do
  it 'shows all of the cooks from the given restuarant' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: false, dishes: 6)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)
    cook_2 = restaurant_2.cooks.create!(name: "Dave", serv_safe_certified: true, dishes_known: 14, restaurant_id: 2)
    cook_3 = restaurant_1.cooks.create!(name: "Doug", serv_safe_certified: true, dishes_known: 11, restaurant_id: 1)

    visit "/restaurants/#{restaurant_1.id}/cooks"
    within "#cooks" do
      expect(page).to have_content(cook_1.name)
      expect(page).to have_content(cook_1.serv_safe_certified)
      expect(page).to have_content(cook_1.dishes_known)
      expect(page).to have_content(cook_1.restaurant_id)
      expect(page).to have_content(cook_3.name)
      expect(page).to have_content(cook_3.serv_safe_certified)
      expect(page).to have_content(cook_3.dishes_known)
      expect(page).to have_content(cook_3.restaurant_id)
      expect(page).not_to have_content(cook_2.name)
      expect(page).not_to have_content(cook_2.dishes_known)
      expect(page).not_to have_content(cook_2.restaurant_id)
    end
  end

  it 'shows a link to the cooks and restaurants index at the top of the page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)

    visit "/restaurants/#{restaurant_1.id}/cooks"

    expect(page).to have_link('Cooks', :href=>'/cooks')
    expect(page).to have_link('Restaurants', :href=>'/restaurants')
	end
end