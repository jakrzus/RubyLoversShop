# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CartItems', type: :request do
  describe 'PUT /cart_items/:id' do
    let!(:unauthorized_user) { create :user }
    let!(:product) { create :product }
    let!(:item) { create :cart_item, :with_cart }

    before do
      sign_in item.user
    end

    context 'when the user is the cart owner' do
      it 'updates cart_items quantity to 12' do
        put "/cart_items/#{item.id}", params: { cart_item: { quantity: 12 } }
        follow_redirect!
        expect(response.body).to include('Item updated successfully')
        expect(item.reload.quantity).to eq(12)
      end

      it 'deletes the item if the quantity is set to zero' do
        cart = item.cart
        put "/cart_items/#{item.id}/", params: { cart_item: { quantity: 0 } }
        follow_redirect!
        expect(response.body).to include('Item removed successfully')
        expect(cart.cart_items).to be_empty
      end
    end

    context 'when the user is not the cart owner' do
      before do
        sign_out item.user
        sign_in unauthorized_user
      end

      it 'does not update item' do
        put "/cart_items/#{item.id}", params: { cart_item: { quantity: 12 } }
        follow_redirect!
        expect(response.body).to include('You are not authorized')
        expect(item.reload.quantity).to eq(1)
      end
    end
  end
end
