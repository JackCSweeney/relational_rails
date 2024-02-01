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

# User Story 7, Parent Child Count

# As a visitor
# When I visit a parent's show page
# I see a count of the number of children associated with this parent

  it 'shows a count of count of the cooks associated with the restaurant' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)
    cook_2 = restaurant_1.cooks.create!(name: "Dan 2", serv_safe_certified: true, dishes_known: 14, restaurant_id: 1)
    cook_3 = restaurant_1.cooks.create!(name: "Dan 3", serv_safe_certified: true, dishes_known: 15, restaurant_id: 1)
    
    visit "/restaurants/#{restaurant_1.id}"

    expect(page).to have_content("Cooks: 3")
  end

  it 'shows a link to the cooks and restaurants index at the top of the page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)

    visit "/restaurants/#{restaurant_2.id}"

    expect(page).to have_link('Cooks', :href=>'/cooks')
    expect(page).to have_link('Restaurants', :href=>'/restaurants')
  end
end