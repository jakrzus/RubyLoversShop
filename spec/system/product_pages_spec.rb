# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'ProductPages', type: :system do
  let!(:product) { create :product }
  let!(:user) { create :user }

  before do
    driven_by(:rack_test)
    visit root_path
    click_on 'Sign In'
    fill_in_sign_in_form_as user
    click_on 'Log in'
  end

  it 'alllows user to visit products page by clicking on the product name' do
    visit root_path
    find('.product-card').click_on product.name
    expect(page).to have_content(product.name)
    expect(page).to have_content(product.price)
    expect(page).to have_content(product.photos.first)
    expect(page).to have_content(product.description)
  end

  it 'alllows user to visit products page by clicking on the product photo' do
    visit root_path
    click_on "product #{product.id} image"
    expect(page).to have_content(product.name)
    expect(page).to have_content(product.price)
    expect(page).to have_content(product.photos.first)
    expect(page).to have_content(product.description)
  end
end
