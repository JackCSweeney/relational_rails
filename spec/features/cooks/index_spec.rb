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

	it 'shows a link to the cooks index at the top of the page' do
    restaurant_1 = Restaurant.create!(name: "Proto's", open: true, dishes: 25)
    restaurant_2 = Restaurant.create!(name: "Pam's", open: true, dishes: 5)
    cook_1 = restaurant_1.cooks.create!(name: "Dan", serv_safe_certified: true, dishes_known: 13, restaurant_id: 1)

    visit "/cooks"

    expect(page).to have_link('Cooks', :href=>'/cooks')
	end
end