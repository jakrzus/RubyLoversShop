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
      order = payment.order
      result = OrderServices::SetPaymentStatus.new.call payment, event
      flash.now[result.flash[:type]] = result.flash[:message]
      render :show, locals: { order: order, order_presenter: OrderPresenter.new(order) }
    end

    private

    def event_params
      params.require(:event).permit(:id, :payment_id)
    end

    def event
      event_params(:name)
    end

    def payment
      Payment.find(event_params[:payment_id])
    end
  end
end
