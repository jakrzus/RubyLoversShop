# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminPayments', type: :request do
  let!(:admin) { create :admin_user }
  let(:order) { create :order }

  describe 'POST /admin/orders/set_payment' do
    before do
      sign_in admin
    end

    it 'change order status to completed only once' do
      post '/admin/set_payment', params: { payment_id: order.payment.id.to_s, event: :complete }
      expect(response.body).to include 'Succesfully changed payment status!'
      post '/admin/set_payment', params: { payment_id: order.payment.id.to_s, event: :cancel }

      expect(response.body).not_to include "Event 'cancel' cannot transition from 'completed'"
    end
  end
end
