# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminUpdatingProducts', type: :system do
  let!(:category) { create :category } # rubocop:disable  RSpec/LetSetup
  let!(:brand) { create :brand } # rubocop:disable  RSpec/LetSetup
  let!(:existing_product) { create :product }
  let(:updated_product) { build_stubbed :product }
  let(:admin) { create :admin_user }

  before do
    driven_by(:rack_test)
    login_admin admin
    visit admin_root_path
  end

  it 'allows admin to update a product' do
    click_on 'Edit'
    fill_in_product_form updated_product
    click_button 'Submit'
    expect(page).to have_content('Product was successfully updated')
    expect(page).to have_content(updated_product.name)
    expect(page).to have_no_content(existing_product.name)
  end
end
