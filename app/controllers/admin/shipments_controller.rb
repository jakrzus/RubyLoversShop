# frozen_string_literal: true

module Admin
  class ShipmentsController < AdminController
    def update
      result = OrderServices::SetPaymentStatus.new.call shipment, event
      flash[result.flash[:type]] = result.flash[:message]
      redirect_to admin_order_path shipment.order
    end

    private

    def event
      params[:event]
    end

    def shipment
      Shipment.find params[:id]
    end
  end
end
