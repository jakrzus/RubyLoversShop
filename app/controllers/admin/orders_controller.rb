# frozen_string_literal: true

module  Admin
  class OrdersController < AdminController
    def index
      @pagy, orders = pagy(Order.order(created_at: :desc).includes(:user))
      render :index, locals: { orders: orders }
    end

    def show
      order = Order.find(params[:id])
      products = order.products.includes(%i[brand category])
      render :show, locals: { order: order, products: products, order_presenter: OrderPresenter.new(order) }
    end

    def set_payment
      payment = Payment.find(params[:payment_id])
      event = params[:event]
      order = payment.order
      result = OrderServices::SetPaymentStatus.new.call payment, event
      flash.now[:alert] = 'Invalid request!' unless result
      flash.now[:notice] = 'Succesfully changed payment status!' if result
      render :show, locals: { order: order, order_presenter: OrderPresenter.new(order) }
    end
  end
end
