# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminProducts', type: :system do
  before do
    driven_by(:rack_test)
    create :brand
    create :category
    admin = create :admin_user
    visit admin_root_path
    fill_in_sign_in_form_as admin
    click_on 'Log in'
    visit new_admin_product_path
  end

  let!(:product) { build_stubbed :product }
  let!(:product_without_name) { build_stubbed :product, :without_name }

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
end
