# frozen_string_literal: true

module Admin
  class ShipmentsController < StatusesController
    private

    def resource
      @shipment ||= Shipment.find(params[:id]) # rubocop:disable Naming/MemoizedInstanceVariableName
    end
  end
end
