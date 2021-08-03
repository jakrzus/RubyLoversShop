# frozen_string_literal: true

module OrderServices
  class SetShipmentStatus
    def call(shipment, event)
      shipment.aasm.fire!(event)
      OpenStruct.new(flash: { type: :notice, message: 'Succesfully changed shipment status' }, payload: shipment)
    rescue AASM::InvalidTransition, ActiveModel::ValidationError => e
      OpenStruct.new(flash: { type: :alert, message: e.message }, payload: e)
    end
  end
end
