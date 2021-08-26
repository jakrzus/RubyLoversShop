require 'rails_helper'

RSpec.describe 'CartItems', type: :request do
  describe 'PUT /cart_items/:id' do
    let!(:unauthorized_user) { create :user }
    let!(:product) { create :product }
    let!(:item) { create :cart_item, :with_cart }

    before do
      sign_in item.user
    end

    it 'updates cart_items quantity to 12 if user is the cart owner' do
      put "/cart_items/#{item.id}", params: { cart_item: { quantity: 12 } }
      follow_redirect!
      expect(response.body).to include('Item updated successfully')
      expect(item.reload.quantity).to eq(12)
    end

    it 'does not update item if the user is not the cart owner' do
      sign_out item.user
      sign_in unauthorized_user
      put "/cart_items/#{item.id}", params: { cart_item: { quantity: 12 } }
      follow_redirect!
      expect(response.body).to include('You are not authorized')
      expect(item.reload.quantity).to eq(1)
    end

    it 'deletes the item if the quantity is set to zero' do
      cart = item.cart
      put "/cart_items/#{item.id}/", params: { cart_item: { quantity: 0 } }
      follow_redirect!
      expect(response.body).to include('Item removed successfully')
      expect(cart.cart_items).to be_empty
    end
  end
end
