module Admin
  class PaymentsController < AdminController
    def update
      result = OrderServices::SetPaymentStatus.new.call payment, event
      flash[result.flash[:type]] = result.flash[:message]
      redirect_to admin_order_path payment.order
    end

    private

    def event
      params[:event]
    end

    def payment
      Payment.find(params[:id])
    end
  end
end
