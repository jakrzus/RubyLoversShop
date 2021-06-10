# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminProducts', type: :request do
  before do
    create :category
    create :brand
    admin = create :admin_user
    log_in_admin admin
  end

  let!(:new_product) { build_stubbed :product }
  let(:existing_product) { create :product }

  describe 'POST /admin/products/new' do
    it 'creates new products' do
      post admin_products_path, params: { product: new_product.as_json }
      follow_redirect!

      expect(response.body).to include('Product was successfully created')
    end
  end

  describe 'DELETE /admin/products/:id' do
    it 'deletes a product' do
      delete admin_product_path(existing_product)
      follow_redirect!

      expect(response.body).to include('Product was successfully deleted')
    end
  end
end
