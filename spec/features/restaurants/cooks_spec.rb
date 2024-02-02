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

# As a visitor
# When I visit a Parent Children Index page
# Then I see a link to add a new adoptable child for that parent "Create Child"
# When I click the link
# I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
# When I fill in the form with the child's attributes:
# And I click the button "Create Child"
# Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
# a new child object/row is created for that parent,
# and I am redirected to the Parent Childs Index page where I can see the new child listed

  it 'shows a link to add a new cook to the restaurant and can click it to be brought to the /new page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)

    visit "/restaurants/#{restaurant_1.id}/cooks"

    expect(page).to have_link("Create Cook", :href=>"/restaurants/#{restaurant_1.id}/cooks/new")

    click_link "Create Cook"

    expect(current_path).to eq("/restaurants/#{restaurant_1.id}/cooks/new")
  end

  it 'has a form to add a new cook and their attributes' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)

    visit "/restaurants/#{restaurant_1.id}/cooks/new"

    expect(page).to have_content("Name:")
    expect(page).to have_field("name")
    expect(page).to have_content("ServSafe Certification:")
    expect(page).to have_field("serv_safe_certified")
    expect(page).to have_content("Dishes Known:")
    expect(page).to have_field("dishes_known")
  end

  it 'can fill in the form, submit, be returned to the parent child index, and see the new child' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    visit "/restaurants/#{restaurant_1.id}/cooks/new"

    fill_in "name", with: "Test Guy"
    check "serv_safe_certified"
    fill_in "dishes_known", with: "32"
    click_on "submit"

    expect(current_path).to eq("/restaurants/#{restaurant_1.id}/cooks")
    expect(page).to have_content("Test Guy")
    expect(page).to have_content("true")
    expect(page).to have_content("32")
  end


end