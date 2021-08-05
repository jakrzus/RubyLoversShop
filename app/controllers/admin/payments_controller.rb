# frozen_string_literal: true

module Admin
  class PaymentsController < StatusesController
    private

    def resource
      @resource ||= Payment.find(params[:id])
    end
  end
end
