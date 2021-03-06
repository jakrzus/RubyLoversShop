# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'Carts', type: :request do
  let!(:user) { create :user }
  let!(:product) { create :product }

  describe 'POST /add_product/:id' do
    before do
      log_in user
    end

    it 'allows adding only one product of its kind' do
      2.times { post "/add_product/#{product.id}" }

      expect(response).to redirect_to '/'
      expect(user.cart.cart_items.count).to eq 1
    end

    it 'allows adding multiple items of a product' do
      post "/add_product/#{product.id}", params: { quantity: 4 }

      expect(response).to redirect_to '/'
      expect(user.cart.cart_items.find_by(product_id: product.id).quantity).to eq 4
    end
  end

  describe 'GET /cart' do
    before do
      log_in user
    end

    it 'display product added to the cart' do
      post "/add_product/#{product.id}"
      get '/cart'

      expect(response.body).to include product.name
    end
  end

  describe 'POST /cart' do
    before do
      log_in user
    end

    it 'checks out the order' do
      post "/add_product/#{product.id}"
      post '/cart'
      order_items = user.orders.first.cart_items.map(&:product)

      expect(order_items).to include product
    end

    it 'does not allow for new check out if there is one unfinished' do
      2.times do
        post "/add_product/#{product.id}"
        post '/cart'
      end
      follow_redirect!
      expect(response.body).to include 'You must finish check out'
      expect(user.orders.count).to eq 1
    end
  end

  describe 'DELETE /cart' do
    before do
      log_in user
    end

    it 'deletes all products from the cart' do
      post "/add_product/#{product.id}"
      delete '/cart'

      expect(user.cart.cart_items.count).to eq 0
    end
  end
end
