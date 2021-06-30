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

      expect(user.cart.cart_items.count).to eq 1
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
end