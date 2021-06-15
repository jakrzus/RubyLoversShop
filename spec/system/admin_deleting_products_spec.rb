# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminDeletingProducts', type: :system do
  let(:admin) { create :admin_user }
  let!(:product) { create :product }

  before do
    driven_by(:rack_test)
    login_admin admin
  end

  it 'allows admin to delete a product' do
    visit admin_root_path
    click_button 'Delete'

    expect(page).to have_no_content(product.name)
  end
end
