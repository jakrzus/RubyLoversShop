# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'ShoppingCarts', type: :system do
  include ActiveSupport::NumberHelper

  let!(:user) { create :user }
  let!(:product) { create :product }

  before do
    driven_by(:rack_test)
    visit root_path
    click_on 'Sign In'
    fill_in_sign_in_form_as user
    click_on 'Log in'
  end

  it 'allows user to add a product to the shopping cart from the home page' do
    visit root_path
    click_button 'Add to cart'
    click_on user.email
    click_on 'Shopping Cart'

    expect(page).to have_content 'Your Cart'
    expect(page).to have_content product.name
    expect(page).to have_content product.price
  end

  it 'allows user to add a product to the shopping cart from the product page' do
    visit root_path
    click_on product.name
    click_button 'Add to cart'
    click_on user.email
    click_on 'Shopping Cart'

    expect(page).to have_content 'Your Cart'
    expect(page).to have_content product.name
    expect(page).to have_content product.price
  end

  it 'allows user to add three items of a product to the shopping cart' do
    visit root_path
    click_on product.name
    fill_in 'quantity', with: 3
    click_button 'Add to cart'
    click_on user.email
    click_on 'Shopping Cart'

    expect(page).to have_content 'Your Cart'
    expect(page).to have_content product.name
    expect(page).to have_content number_to_currency(product.price)
    expect(page).to have_content number_to_currency(product.price * 3)
  end

  it 'allows user to change number of products in the shopping cart' do
    visit root_path
    click_on product.name
    click_button 'Add to cart'
    click_on user.email
    click_on 'Shopping Cart'
    fill_in 'Quantity', with: 15
    click_on 'Update'

    expect(page).to have_content 'Item updated successfully'
    click_on 'Check Out'
    quantity = find('#cart_item_quantity')
    expect(quantity.value).to eq('15')
  end

  it 'allows user to remove item from the shopping cart with one click' do
    visit root_path
    click_on product.name
    click_button 'Add to cart'
    click_on user.email
    click_on 'Shopping Cart'
    click_button 'Remove'

    expect(page).to have_content 'Item removed successfully'
    expect(page).not_to have_content product.name
    expect(page).not_to have_content number_to_currency(product.price)
  end

  it 'allows user to check out' do
    visit root_path
    click_on product.name
    click_button 'Add to cart'
    click_on user.email
    click_on 'Shopping Cart'
    click_on 'Check Out'

    expect(page).to have_content 'Order has been created'
  end
end
