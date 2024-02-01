require 'rails_helper'

RSpec.describe 'the restaurants index page' do
  it 'can list the restaurants in the system' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)

    visit "/restaurants"

    expect(page).to have_content(restaurant_1.name)
    expect(page).to have_content(restaurant_2.name)
  end

# User Story 6, Parent Index sorted by Most Recently Created 

# As a visitor
# When I visit the parent index,
# I see that records are ordered by most recently created first
# And next to each of the records I see when it was created
  it 'shows the restaurants in the system and the time they were created' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)

    visit "/restaurants"

    expect(page).to have_content(restaurant_1.name)
    expect(page).to have_content(restaurant_2.name)
    expect(page).to have_content(restaurant_1.created_at)
    expect(page).to have_content(restaurant_2.created_at)
  end

  it 'orders the restaurants by the time that they were created' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)

    visit "/restaurants"

    expect(restaurant_2.name).to appear_before(restaurant_1.name)
  end

  it 'shows a link to the cooks index at the top of the page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)

    visit "/restaurants"

    expect(page).to have_link('Cooks', :href=>'/cooks')
  end
end