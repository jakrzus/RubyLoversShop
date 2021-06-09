# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminDashboards', type: :request do
  before do
    create_list(:category, 3)
    create_list(:product, 5)
  end

  describe 'GET /admin' do
    let!(:user) { create :user }
    let!(:admin) { create :admin_user }

    it 'redirects to home page if logged in user is not an admin' do
      log_in user
      get admin_root_path

      expect(response).to redirect_to root_path
    end

    it 'displays all products on /admin' do
      log_in_admin admin
      get admin_root_path

      Product.all.each do |product|
        expect(response.body).to include(product.name)
      end
    end
  end
end
