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

  it 'filters products via category' do
    visit root_path
    category = Category.first
    select category.name, from: 'filter_category_id'
    click_on 'Save Filter'

    expect(page.all('.product-card').count).to eq(category.products.count)
  end

  it 'filters products via brand' do
    visit root_path
    brand = Brand.first
    select brand.name, from: 'filter_brand_id'
    click_on 'Save Filter'

    expect(page.all('.product-card').count).to eq(brand.products.count)
  end
end
