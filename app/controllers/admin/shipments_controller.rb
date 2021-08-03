# frozen_string_literal: true

module Admin
  class ShipmentsController < AdminController
    def update
      result = OrderServices::SetShipmentStatus.new.call shipment, event
      respond_to do |format|
        format.html do
          set_flash_message result, flash
          redirect_to admin_order_path(order)
        end
        format.json do
          render json: result.payload
        end
      end
    end

    private

    def event
      params[:event]
    end

    def shipment
      @shipment ||= Shipment.find(params[:id])
    end

    def order
      shipment.order
    end

    def set_flash_message(result, flash)
      flash[result.flash[:type]] = result.flash[:message]
    end
  end
end
