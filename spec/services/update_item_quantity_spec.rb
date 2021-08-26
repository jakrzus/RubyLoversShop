# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UpdateItemQuantityService' do
  subject(:update_item_quantity) { CartServices::UpdateItemQuantity.new }

  let!(:product) { create :product }
  let!(:item) { create :cart_item, :with_cart }
  let!(:unauthorized_user) { create :user }

  params = { quantity: '10' }

  it 'changes item quantity to 10 if the cart belongs to the user' do
    user = item.cart.user
    response = update_item_quantity.call(user, item, params)
    expect(response.success?).to be true
    expect(response.flash).to eq('Item updated successfully')
    expect(item.quantity).to eq(10)
  end

  it 'does not remove an item from a cart if the user is not the cart owner' do
    response = update_item_quantity.call(unauthorized_user, item, params)
    expect(response.success?).to be(false)
    expect(response.flash).to eq 'You are not authorized'
    expect(item.quantity).to eq(1)
  end

  it 'removes item from the cart if quantity is zero' do
    user = item.cart.user
    params = { quantity: '0' }
    response = update_item_quantity.call(user, item, params)
    expect(response.success?).to be(true)
    expect(response.flash).to eq('Item removed successfully')
    expect(item.cart.cart_items).to be_empty
  end

  it 'does not update the item if there is no quantity in params' do
    user = item.user
    params = {}
    expect { update_item_quantity.call(user, item, params) }.to raise_error('Quantity can not be nil')
    expect(item.quantity).to eq(1)
  end
end
