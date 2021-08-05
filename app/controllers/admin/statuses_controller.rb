# frozen_string_literal: true

module Admin
  class StatusesController < AdminController
    def update
      response = service.call(resource, event)
      respond_to do |format|
        format.html do
          set_flash(flash, response)
          redirect_to admin_order_path(order)
        end
        format.json do
          render json: response.payload
        end
      end
    end

    private

    def event
      params[:event]
    end

    def resource
      nil
    end

    def service
      OrderServices::SetStatus.new
    end

    def order
      resource.instance_of?(Order) ? resource : resource.order
    end

    def set_flash(flash, response)
      flash[response.flash[:type]] = response.flash[:message]
    end
  end
end
