require 'rails_helper'

RSpec.describe 'Edit Cook Page' do
# As a visitor
# When I visit a Child Show page
# Then I see a link to update that Child "Update Child"
# When I click the link
# I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
# When I click the button to submit the form "Update Child"
# Then a `PATCH` request is sent to '/child_table_name/:id',
# the child's data is updated,
# and I am redirected to the Child Show page where I see the Child's updated information
  it 'has a link to page to update a cook' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)

    visit "/cooks/#{cook_1.id}"

    expect(page).to have_link('Update Cook', :href=>"/cooks/#{cook_1.id}/edit")
  end

  it 'shows the form to edit a cooks info' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)

    visit "/cooks/#{cook_1.id}/edit"

    expect(page).to have_field("name")
    expect(page).to have_field("dishes_known")
    expect(page).to have_field("serv_safe_certified")
    expect(page).to have_selector('input[type=submit]')
  end

  it 'can fill out the form and submit it to change the attributes of the restaurant and be brought to that restaurants show page when submitted to see the changes' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)

    visit "/cooks/#{cook_1.id}/edit"

    fill_in "name", with: "Test Guy"
    check "serv_safe_certified"
    fill_in "dishes_known", with: "46"
    click_on "submit"

    expect(page).to have_current_path("/cooks/#{cook_1.id}")
    expect(page).to have_content("Test Guy")
    expect(page).to have_content("46")
    expect(page).to have_content("true")
  end
end