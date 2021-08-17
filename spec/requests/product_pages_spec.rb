# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ProductPages', type: :request do
  let!(:product) { create :product }

  headers = { 'ACCEPT' => 'application/json' }

  describe 'GET /products/:id' do
    it 'returns the product' do
      get "/products/#{product.id}", headers: headers
      result = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(result['name']).to eq(product.name)
      expect(result['price']).to eq(product.price.to_s)
      expect(result['description']).to eq(product.description)
    end
  end
end
