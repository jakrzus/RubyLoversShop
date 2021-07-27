# frozen_string_literal: true

module Admin
  class StatusesController < AdminController
    def update
      result = service.call resource, event
      flash[result.flash[:type]] = result.flash[:message]
      redirect_to admin_order_path order
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
      resource.order || self
    end
  end
end
