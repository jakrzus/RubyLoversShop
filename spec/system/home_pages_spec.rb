# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HomePages', type: :system do
  before do
    driven_by(:rack_test)
    Product.destroy_all
    create_list(:category, 3)
    create_list(:product, 5, :with_photo)
    create_list(:product, 5)
  end

  it 'shows all products' do
    visit root_path
    expect(page.all('.product-card').count).to eq(10)
  end
end
