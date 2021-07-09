# frozen_string_literal: true

module  Admin
  class OrdersController < AdminController
    def index
      @pagy, orders = pagy(Order.order(created_at: :desc))
      render :index, locals: { orders: orders }
    end

    def show
      order = Order.find(params[:id])
      render :show, locals: { order: order, order_presenter: OrderPresenter.new(order) }
    end
  end
end
