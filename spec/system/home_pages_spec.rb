# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HomePages', type: :system do
  before do
    driven_by(:rack_test)
    Product.destroy_all
    %i[brand category].each { |item| create_list(item, 3) }
    create_list(:product, 5, :with_photo)
    create_list(:product, 5)
    visit root_path
  end

  def card_count(page)
    page.all('.product-card').count
  end

  it 'shows all products' do
    expect(card_count(page)).to eq(10)
  end

  it 'filters products by category' do
    category = Category.first
    select category.name, from: 'filter_category_id'
    click_on 'Save Filter'
    expect(card_count(page)).to eq(category.products.count)
  end

  it 'filters products by brand' do
    brand = Brand.first
    select brand.name, from: 'filter_brand_id'
    click_on 'Save Filter'
    expect(card_count(page)).to eq(brand.products.count)
  end
end
