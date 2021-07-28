# frozen_string_literal: true

require 'rails_helper'
require './spec/support/helpers'

RSpec.describe 'AdminPayments', type: :request do
  let!(:admin) { create :admin_user }
  let!(:payment) { create :payment }

  describe 'PUT /admin/payments/:id' do
    before do
      sign_in admin
    end

    it 'change payment status to completed only once' do
      put "/admin/payments/#{payment.id}", params: { event: :complete }
      put "/admin/payments/#{payment.id}", params: { event: :cancel }
      follow_redirect!
      expect(response.body).to include CGI.escapeHTML("Event 'cancel' cannot transition from 'completed'")
    end

    it 'does not change payment status from cancelled to completed' do
      put "/admin/payments/#{payment.id}", params: { event: :cancel }
      put "/admin/payments/#{payment.id}", params: { event: :complete }
      follow_redirect!
      expect(response.body).to include CGI.escapeHTML(" Event 'complete' cannot transition from 'failed'.")
    end
  end
end
