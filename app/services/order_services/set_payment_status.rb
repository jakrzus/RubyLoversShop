# frozen_string_literal: true

module OrderServices
  class SetPaymentStatus
    def call(payment, event)
      response = payment.aasm.fire! event
      OpenStruct.new(flash: { type: :notice, message: 'Succesfully changed payment status!' }, payload: response)
    rescue AASM::InvalidTransition, ActiveModel::ValidationError => e
      OpenStruct.new(flash: { type: :alert, message: e.message }, payload: e)
    end
  end
end
