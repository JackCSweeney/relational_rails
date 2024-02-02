require 'rails_helper'

RSpec.describe 'The Restaurant Edit page' do

# As a visitor
# When I visit a parent show page
# Then I see a link to update the parent "Update Parent"
# When I click the link "Update Parent"
# Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/parents/:id',
# the parent's info is updated,
# and I am redirected to the Parent's Show page where I see the parent's updated info
  it 'shows a link to go to the /edit page on the /restaurant/:id page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)

    visit "/restaurants/#{restaurant_1.id}"

    expect(page).to have_link('Update Restaurant', :href=>"/restaurants/#{restaurant_1.id}/edit")
  end

  it 'shows the form to edit a restaurants info' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)

    visit "/restaurants/#{restaurant_1.id}/edit"

    expect(page).to have_field("name")
    expect(page).to have_field("dishes")
    expect(page).to have_field("open")
    expect(page).to have_selector('input[type=submit]')
  end

  it 'can fill out the form and submit it to change the attributes of the restaurant and be brought to that restaurants show page when submitted to see the changes' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)

    visit "/restaurants/#{restaurant_1.id}/edit"

    fill_in "name", with: "Testaurant"
    check "open"
    fill_in "dishes", with: "46"
    click_on "submit"

    expect(page).to have_current_path("/restaurants/#{restaurant_1.id}")
    expect(page).to have_content("Testaurant")
    expect(page).to have_content("46")
    expect(page).to have_content("true")
  end
end