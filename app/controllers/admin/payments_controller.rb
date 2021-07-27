# frozen_string_literal: true

module Admin
  class PaymentsController < StatusesController
    private

    def resource
     @payment ||= Payment.find(params[:id])
    end
  end
end
