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

  it 'shows a link to the cooks and restaurants index at the top of the page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)

    visit "/restaurants"

    expect(page).to have_link('Cooks', :href=>'/cooks')
    expect(page).to have_link('Restaurants', :href=>'/restaurants')
  end

  # As a visitor
  # When I visit the Parent Index page
  # Then I see a link to create a new Parent record, "New Parent"
  # When I click this link
  # Then I am taken to '/parents/new' where I  see a form for a new parent record
  # When I fill out the form with a new parent's attributes:
  # And I click the button "Create Parent" to submit the form
  # Then a `POST` request is sent to the '/parents' route,
  # a new parent record is created,
  # and I am redirected to the Parent Index page where I see the new Parent displayed.

  it 'shows a link to create a new restaurant record' do
    visit "/restaurants"

    expect(page).to have_link('New Restaurant', :href=>"/restaurants/new")
  end

  it 'can click on the link and be brought to a form to add a new restaurant' do
    visit "/restaurants"

    click_on("New Restaurant")

    expect(page).to have_field("name")
    expect(page).to have_field("dishes")
    expect(page).to have_field("open")
    expect(page).to have_selector('input[type=submit]')
  end

  it 'can fill out the form and submit and be brought to the /restaurants page and have the new content' do
    visit "/restaurants/new"

    fill_in "name", with: "Testaurant"
    check "open"
    fill_in "dishes", with: "46"
    click_on "submit"

    expect(page).to have_current_path("/restaurants")
    expect(page).to have_content("Testaurant")
  end
  
# As a visitor
# When I visit the parent index page
# Next to every parent, I see a link to edit that parent's info
# When I click the link
# I should be taken to that parent's edit page where I can update its information just like in User Story 12

  it 'shows the link to edit a specific restaurant next to each restaurant' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)

    visit "/restaurants"

    expect(page).to have_link("Edit #{restaurant_1.name}", :href=>"/restaurants/#{restaurant_1.id}/edit")
    expect(page).to have_link("Edit #{restaurant_2.name}", :href=>"/restaurants/#{restaurant_2.id}/edit")
  end

  it 'can click the link and be taken to that restaurants edit page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)

    visit "/restaurants"
    click_on "Edit #{restaurant_1.name}"

    expect(current_path).to eq("/restaurants/#{restaurant_1.id}/edit")
  end

end