# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminOrdersStatuses', type: :request do
  describe 'PUT admin/orders/order_statuses' do
    let!(:admin) { create :admin_user }
    let!(:user) { create :user }
    let!(:order) { create :order }

    headers = { 'ACCEPT' => 'application/json' }

    before do
      sign_in admin
    end

    it 'does not allow to change order to completed if payment is not completed and shipment is not shipped' do
      put "/admin/order_statuses/#{order.id}", params: { event: :complete }, headers: headers
      expect(JSON.parse(response.body)).to include
      "Event 'complete' cannot transition from 'new'. Failed callback(s): [:completion_permitted?]."
    end

    it 'does allow to change order to completed when payment is completed and shipment is shipped' do
      put "/admin/payments/#{order.payment.id}", params: { event: :complete }, headers: headers
      put "/admin/shipments/#{order.shipment.id}", params: { event: :prepare }, headers: headers
      put "/admin/shipments/#{order.shipment.id}", params: { event: :ship }, headers: headers
      put "/admin/order_statuses/#{order.id}", params: { event: :complete }, headers: headers

      expect(JSON.parse(response.body)['state']).to eq('completed')
    end

    it 'does allow admin to change order status to failed' do
      put "/admin/order_statuses/#{order.id}", params: { event: :cancel }, headers: headers

      expect(JSON.parse(response.body)['state']).to eq('failed')
    end

    it 'does not allow to change order to failed if user is not logged in' do
      sign_out admin
      put "/admin/order_statuses/#{order.id}", params: { event: :cancel }, headers: headers

      expect(JSON.parse(response.body)['error']).to eq('You need to sign in or sign up before continuing.')
    end

    it 'does not allow to change order to failed if user is not an admin' do
      sign_out admin
      sign_in user
      put "/admin/order_statuses/#{order.id}", params: { event: :cancel }, headers: headers

      expect(JSON.parse(response.body)['error']).to eq('You are not authorized')
    end
  end
end
