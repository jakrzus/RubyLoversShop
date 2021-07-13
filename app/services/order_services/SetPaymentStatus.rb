module OrderServices
  class SetPaymentStatus
    def call(payment, event)
      response = payment.aasm.fire! event
    end
  end
end
