# frozen_string_literal: true

class OrderPresenter
  def initialize(order)
    @order = order
  end

  def total_price
    items = @order.cart_items.includes(:product)
    items.map { |item| CartItemPresenter.new(item).total_price }.sum
  end

  def created_at
    @order.created_at.strftime('%F %R')
  end
end
