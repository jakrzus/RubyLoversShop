# frozen_string_literal: true

module Admin
  class ShipmentsController < StatusesController
    private

    def resource
      @resource ||= Shipment.find(params[:id])
    end
  end
end
