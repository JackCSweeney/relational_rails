require 'rails_helper'

RSpec.describe 'the cooks index page' do
	it 'can list all of the cooks and their attributes' do
		restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
		restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)
		cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)
		cook_2 = restaurant_2.cooks.create!(name: "Dave", serv_safe_certified: true, dishes_known: 10, restaurant_id: 1)

		visit "/cooks"

		expect(page).to have_content(cook_1.name)
		expect(page).to have_content(cook_1.serv_safe_certified)
		expect(page).to have_content(cook_1.dishes_known)
		expect(page).to have_content(cook_1.restaurant_id)
		expect(page).to have_content(cook_2.name)
		expect(page).to have_content(cook_2.serv_safe_certified)
		expect(page).to have_content(cook_2.dishes_known)
		expect(page).to have_content(cook_2.restaurant_id)
	end

	it 'shows a link to the cooks and restaurants index at the top of the page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)

    visit "/cooks"

    expect(page).to have_link('Cooks', :href=>'/cooks')
		expect(page).to have_link('Restaurants', :href=>'/restaurants')
	end

	it 'only shows cooks that are servsafe certified' do
		restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)
		cook_2 = restaurant_1.cooks.create!(name: "Dave", serv_safe_certified: true, dishes_known: 10, restaurant_id: 1)
		cook_3 = restaurant_1.cooks.create!(name: "Dusty", serv_safe_certified: false, dishes_known: 10, restaurant_id: 1)

		visit "/cooks"

		expect(page).to have_content(cook_1.name)
		expect(page).to have_content(cook_2.name)
		expect(page).not_to have_content(cook_3.name)
	end

# As a visitor
# When I visit the `child_table_name` index page or a parent `child_table_name` index page
# Next to every child, I see a link to edit that child's info
# When I click the link
# I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 14

	it 'shows a link to edit each specific cook on the cooks index page' do
		restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)
		cook_2 = restaurant_1.cooks.create!(name: "Dave", serv_safe_certified: true, dishes_known: 10, restaurant_id: 1)
		cook_3 = restaurant_1.cooks.create!(name: "Dusty", serv_safe_certified: true, dishes_known: 10, restaurant_id: 1)

		visit "/cooks"

		expect(page).to have_link("Edit #{cook_1.name}", :href=>"/cooks/#{cook_1.id}/edit")
		expect(page).to have_link("Edit #{cook_2.name}", :href=>"/cooks/#{cook_2.id}/edit")
		expect(page).to have_link("Edit #{cook_3.name}", :href=>"/cooks/#{cook_3.id}/edit")
	end

	it 'can click on the edit link and be brought to the page to edit that specific cook' do
		restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)
		cook_2 = restaurant_1.cooks.create!(name: "Dave", serv_safe_certified: true, dishes_known: 10, restaurant_id: 1)
		cook_3 = restaurant_1.cooks.create!(name: "Dusty", serv_safe_certified: true, dishes_known: 10, restaurant_id: 1)

		visit "/cooks"
		click_on "Edit #{cook_1.name}"

		expect(current_path).to eq("/cooks/#{cook_1.id}/edit")
	end
end