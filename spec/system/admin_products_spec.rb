# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminProducts', type: :system do
  let!(:category) { create :category } # rubocop:disable  RSpec/LetSetup
  let!(:brand) {  create :brand } # rubocop:disable  RSpec/LetSetup
  let!(:product) { build_stubbed :product }
  let!(:product_without_name) { build_stubbed :product, :without_name }

  before do
    driven_by(:rack_test)
    login_admin
    visit new_admin_product_path
  end

  it 'allows admin to add new products' do
    fill_in_product_form product
    click_button 'Submit'
    expect(page).to have_content('Product was successfully created')
  end

  it 'prevent from saving product with no name' do
    fill_in_product_form product_without_name
    click_button 'Submit'
    expect(page).to have_content('Product was not created')
  end

  it 'allows admin to attach a photo to product' do
    fill_in_product_form product
    attach_file 'product_photos', 'spec/support/watch.webp'
    click_button 'Submit'
    expect(page).to have_css("img[src*='watch.webp']")
  end
end

def login_admin
  admin = create :admin_user
  visit admin_root_path
  fill_in_sign_in_form_as admin
  click_on 'Log in'
end