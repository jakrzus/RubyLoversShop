# frozen_string_literal: true

module Admin
  class OrderStatusesController < StatusesController
    private

    def resource
      @resource ||= Order.find(params[:id])
    end
  end
end
