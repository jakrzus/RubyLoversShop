# frozen_string_literal: true

module Admin
  class OrderStatusesController < StatusesController
    private

    def resource
      @order ||= Order.find(params[:id]) # rubocop:disable Naming/MemoizedInstanceVariableName
    end
  end
end
