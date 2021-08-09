# frozen_string_literal: true

module  Admin
  class OrdersController < AdminController
    def index
      @pagy, orders = pagy(Order.order(created_at: :desc).includes(%i[user]))
      render :index, locals: { orders: orders }
    end

    def show
      order = Order.find(params[:id])
      products = order.products.includes(%i[brand category])
      render :show, locals: { order: order, products: products, order_presenter: OrderPresenter.new(order) }
    end
  end
end
