require 'rails_helper'

RSpec.describe '/cooks/:id page' do
  it 'shows a specific cook and their attributes' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: false, dishes: 6)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)
    cook_2 = restaurant_2.cooks.create!(name: "Doug", serv_safe_certified: false, dishes_known: 12, restaurant_id: 2)

    visit "/cooks/#{cook_1.id}"

    expect(page).to have_content(cook_1.name)
    expect(page).to have_content(cook_1.serv_safe_certified)
    expect(page).to have_content(cook_1.dishes_known)
    expect(page).to have_content(cook_1.restaurant_id)
    expect(page).not_to have_content(cook_2.name)
    expect(page).not_to have_content(cook_2.serv_safe_certified)
    expect(page).not_to have_content(cook_2.dishes_known)
    expect(page).not_to have_content(cook_2.restaurant_id)
  end
end