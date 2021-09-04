# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RemoveItemService' do
  subject(:remove_item) { CartServices::RemoveItem.new }

  let!(:product) { create :product }
  let!(:item) { create :cart_item, :with_cart }
  let!(:unauthorized_user) { create :user }

  it 'removes an item from a cart if the cart belongs to the user' do
    user = item.cart.user
    response = remove_item.call(item, user)
    expect(response.success?).to be true
    expect(response.flash).to eq('Item removed successfully')
    expect(item.cart.cart_items).to be_empty
  end

  it 'does not remove an item from a cart if the user is not the cart owner' do
    response = remove_item.call(item, unauthorized_user)
    expect(response.success?).to be false
    expect(response.flash).to eq 'Cart does not belong to this user!'
    expect(item.cart.cart_items).not_to be_empty
  end
end
