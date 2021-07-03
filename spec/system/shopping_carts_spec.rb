# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'ShoppingCarts', type: :system do
  let!(:user) { create :user }
  let!(:product) { create :product }
  let(:cart) { create :cart }

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
