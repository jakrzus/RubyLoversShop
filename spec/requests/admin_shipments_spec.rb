# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminShipments', type: :request do
  let!(:admin) { create :admin_user }
  let!(:user) { create :user }

  headers = { 'ACCEPT' => 'application/json' }

  describe 'PUT /admin/shipments/:id' do
    before do
      sign_in admin
    end

    let!(:shipment) { create :shipment }

    it 'can not change shipment status to shipped until payment is completed' do
      put "/admin/shipments/#{shipment.id}", params: { event: :prepare }, headers: headers
      put "/admin/shipments/#{shipment.id}", params: { event: :ship }, headers: headers

      expect(response.body).to include("Event 'ship' cannot transition from 'ready'.")
    end

    it 'can change shipment status from pending to canceled' do
      put "/admin/shipments/#{shipment.id}", params: { event: :cancel }, headers: headers

      expect(JSON.parse(response.body)['state']).to eq('canceled')
    end

    it 'can change shipment status from ready to failed' do
      put "/admin/shipments/#{shipment.id}", params: { event: :prepare }, headers: headers
      expect(JSON.parse(response.body)['state']).to eq('ready')
      put "/admin/shipments/#{shipment.id}", params: { event: :cancel }, headers: headers

      expect(JSON.parse(response.body)['state']).to eq('failed')
    end

    it 'can not change shipment status from failed to ready' do
      put "/admin/shipments/#{shipment.id}", params: { event: :prepare }, headers: headers
      put "/admin/shipments/#{shipment.id}", params: { event: :cancel }, headers: headers
      put "/admin/shipments/#{shipment.id}", params: { event: :prepare }, headers: headers

      expect(JSON.parse(response.body)['state']).not_to eq('ready')
      expect(response.body).to include("Event 'prepare' cannot transition from 'failed'.")
    end

    it 'can not change shipment status if signed in  user is not an admin' do
      sign_out admin
      sign_in user
      put "/admin/shipments/#{shipment.id}", params: { event: :prepare }, headers: headers

      expect(JSON.parse(response.body)['error']).to eq('You are not authorized')
    end

    it 'can not change shipment status if there is nobody signed in' do
      sign_out admin
      put "/admin/shipments/#{shipment.id}", params: { event: :prepare }, headers: headers

      expect(JSON.parse(response.body)['error']).to eq('You need to sign in or sign up before continuing.')
    end
  end
end
