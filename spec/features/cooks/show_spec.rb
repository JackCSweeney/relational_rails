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

  it 'shows a link to the cooks and restaurants index at the top of the page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)

    visit "/cooks/#{cook_1.id}"

    expect(page).to have_link('Cooks', :href=>'/cooks')
    expect(page).to have_link('Restaurants', :href=>'/restaurants')
  end

# As a visitor
# When I visit a child show page
# Then I see a link to delete the child "Delete Child"
# When I click the link
# Then a 'DELETE' request is sent to '/child_table_name/:id',
# the child is deleted,
# and I am redirected to the child index page where I no longer see this child
  it 'shows a link to delete a cook from that cooks show page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)

    visit "/cooks/#{cook_1.id}"

    expect(page).to have_link("Delete #{cook_1.name}", :href=>"/cooks/#{cook_1.id}")
  end

  it 'can click on the delete link to delete the cook and it will delete the cook then return the user to the cooks index page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    cook_1 = restaurant_1.cooks.create!(name: "Doug", serv_safe_certified: true, dishes_known: 13)
    cook_2 = restaurant_1.cooks.create!(name: "Dave 2", serv_safe_certified: true, dishes_known: 14)
    cook_3 = restaurant_1.cooks.create!(name: "Dan 3", serv_safe_certified: true, dishes_known: 15)


    visit "/cooks/#{cook_1.id}"
    click_on "Delete #{cook_1.name}"

    expect(current_path).to eq("/cooks")
    expect(page).not_to have_content(cook_1.name)
    expect(page).to have_content(cook_2.name)
    expect(page).to have_content(cook_3.name)
  end
end