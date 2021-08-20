# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AddProductService' do
  subject(:add_product) { CartServices::AddProduct.new }

  let!(:cart) { create :cart }
  let!(:product) { create :product }

  it 'adds product to the cart' do
    add_product.call(cart, product)
    expect(cart.cart_items.includes(:product).pluck(:name)).to include(product.name)
  end

  it 'adds product to the cart twice' do
    add_product.call(cart, product)
    add_product.call(cart, product)
    expect(cart.cart_items.find_by(product_id: product.id).quantity).to eq(2)
  end

  it 'sets cart item quantity correctly' do
    add_product.call(cart, product, 3)
    expect(cart.cart_items.find_by(product_id: product.id).quantity).to eq(3)
  end
end
