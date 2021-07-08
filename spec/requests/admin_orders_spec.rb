# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminOrders', type: :request do
  let!(:admin) { create :admin_user }

  describe 'GET /admin/orders' do
    let!(:order1) { create :order, :big_id }
    let!(:order2) { create :order, :big_id }

    before do
      sign_in admin
    end

    it 'displays last 20 orders' do
      create_list :order, 19, :big_id
      get '/admin/orders'

      expect(response.body).to include order2.id.to_s
      expect(response.body).not_to include order1.id.to_s
    end
  end
end
