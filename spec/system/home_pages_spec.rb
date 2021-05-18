# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HomePages', type: :system do
  before do
    driven_by(:rack_test)
    Product.destroy_all
    create_list(:product, 5)
  end

  it 'shows all products' do
    visit root_path
    expect(page.all('.product-card').count).to eq(5)
    expect(page.all('.product-card-img').count).to eq(5)
    Product.all.each do |product|
      expect(page).to have_content(product.name)
      expect(page).to have_content(product.price)
    end
  end
end
