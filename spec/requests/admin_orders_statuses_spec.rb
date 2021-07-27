# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminOrdersStatuses', type: :request do
  describe 'PUT admin/orders/order_statuses' do
    let!(:admin) { create :admin_user }
    let!(:order) { create :order }

    before do
      sign_in admin
    end

    it 'does not allow to change order to completed if payment is not completed and shipment is not shipped' do
      put "/admin/order_statuses/#{order.id}", params: { event: :complete }
      expect(response.body).to include
      CGI.escapeHTML("Event 'complete' cannot transition from 'new'. Failed callback(s): [:completion_permitted?].")
    end

    # rubocop:disable RSpec/ExampleLength
    it 'does allow to change order to completed when payment is completed and shipment is shipped' do
      put "/admin/payments/#{order.payment.id}", params: { event: :complete }
      put "/admin/shipments/#{order.shipment.id}", params: { event: :prepare }
      put "/admin/shipments/#{order.shipment.id}", params: { event: :ship }
      put "/admin/order_statuses/#{order.id}", params: { event: :complete }
      follow_redirect!
      expect(response.body).to include 'Order status: completed'
    end
    # rubocop:enable RSpec/ExampleLength
  end
end
