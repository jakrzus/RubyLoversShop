# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminDeletingProducts', type: :system do
  before do
    driven_by(:rack_test)
    login_admin
  end

  let!(:product) { create :product }

  it 'allows admin to delete a product' do
    visit admin_root_path
    click_button 'Delete'

    expect(page).to have_no_content(product.name)
  end
end
