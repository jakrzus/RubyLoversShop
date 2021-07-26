# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminShipments', type: :request do
  let!(:admin) { create :admin_user }
  let!(:shipment) { create :shipment }

  describe 'PUT /admin/shipments/:id' do
    before do
      sign_in admin
    end

    it 'can not change shipment status to shipped until payment is completed' do
      put "/admin/shipments/#{shipment.id}", params: { event: :prepare }
      put "/admin/shipments/#{shipment.id}", params: { event: :ship }
      follow_redirect!
      expect(response.body).to include
      CGI.escapeHTML("Event 'ship' cannot transition from 'ready'. Failed callback(s): [:payment_completed?].")
    end

    it 'can change shipment status to shipped if payment is completed' do
      put "/admin/shipments/#{shipment.id}", params: { event: :prepare }
      put "/admin/payments/#{shipment.payment.id}", params: { event: :complete }
      put "/admin/shipments/#{shipment.id}", params: { event: :ship }
      follow_redirect!
      expect(response.body).to include 'Payment status: completed'
    end
  end
end
