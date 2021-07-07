# frozen_string_literal: true

module  Admin
  class OrdersController < AdminController
    def index
      orders = Order.order created_at: :desc
      render :index, locals: { orders: orders }
    end
  end
end
