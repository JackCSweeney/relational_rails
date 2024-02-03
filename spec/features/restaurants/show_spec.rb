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

  it 'shows a link to the specfic cooks for the given restaurant' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)
    cook_2 = restaurant_1.cooks.create!(name: "Dan 2", serv_safe_certified: true, dishes_known: 14, restaurant_id: 1)
    cook_3 = restaurant_1.cooks.create!(name: "Dan 3", serv_safe_certified: true, dishes_known: 15, restaurant_id: 1)
    
    visit "/restaurants/#{restaurant_1.id}"

    expect(page).to have_link('Restaurants Cooks', :href=>"/restaurants/#{restaurant_1.id}/cooks")
  end

# As a visitor
# When I visit a parent show page
# Then I see a link to delete the parent
# When I click the link "Delete Parent"
# Then a 'DELETE' request is sent to '/parents/:id',
# the parent is deleted, and all child records are deleted
# and I am redirected to the parent index page where I no longer see this parent

  it 'shows a link to delete the restaurant on the restaurants show page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)

    visit "/restaurants/#{restaurant_1.id}"

    expect(page).to have_link("Delete #{restaurant_1.name}", :href=>"/restaurants/#{restaurant_1.id}")
  end

  it 'can click on the delete link to delete the record and it will delete the restaurant along with all cooks associated with the restaurant' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)
    cook_1 = restaurant_1.cooks.create!(name: "Doug", serv_safe_certified: true, dishes_known: 13)
    cook_2 = restaurant_1.cooks.create!(name: "Dave 2", serv_safe_certified: true, dishes_known: 14)
    cook_3 = restaurant_2.cooks.create!(name: "Dan 3", serv_safe_certified: true, dishes_known: 15)


    visit "/restaurants/#{restaurant_1.id}"
    click_on "Delete #{restaurant_1.name}"

    expect(current_path).to eq("/restaurants")
    expect(page).not_to have_content(restaurant_1.name)

    visit "/cooks"

    expect(page).not_to have_content(cook_1.name)
    expect(page).not_to have_content(cook_2.name)
    expect(page).to have_content(cook_3.name)
  end
end