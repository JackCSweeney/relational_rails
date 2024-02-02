require 'rails_helper'

RSpec.describe 'the restaurants/:id/cooks/new page' do
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