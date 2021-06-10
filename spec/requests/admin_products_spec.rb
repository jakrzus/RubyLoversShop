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

  let!(:product) { build_stubbed(:product) }

  describe 'POST /admin/products/new' do
    it 'creates new products' do
      post admin_products_path, params: { product: product.as_json }
      follow_redirect!

      expect(response.body).to include('Product was successfully created')
    end
  end
end
