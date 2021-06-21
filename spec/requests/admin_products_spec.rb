# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminProducts', type: :request do # rubocop:disable Metrics/BlockLength
  let!(:category) { create :category }
  let!(:brand) { create :brand }
  let!(:new_product) { build_stubbed :product }
  let!(:existing_product) { create :product }
  let!(:admin) { create :admin_user }

  before do
    log_in_admin admin
  end

  describe 'POST /admin/products' do
    it 'creates new products' do
      post '/admin/products', params: { product: new_product.as_json }
      follow_redirect!

      expect(response.body).to include('Product was successfully created')
    end
  end

  describe 'DELETE /admin/products/:id' do
    it 'deletes a product' do
      delete "/admin/products/#{existing_product.id}"
      follow_redirect!

      expect(response.body).to include('Product was successfully deleted')
    end
  end

  describe 'GET /admin/products/:id/edit' do
    it 'displays edit form' do
      get "/admin/products/#{existing_product.id}/edit"
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT /admin/products/:id' do
    it 'update existing product' do
      put "/admin/products/#{existing_product.id}", params: { product: new_product.as_json }
      expect(Product.find(existing_product.id).name).to eq(new_product.name)
    end
  end
end
