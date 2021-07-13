# frozen_string_literal: true

class OrderPresenter
  def initialize(order)
    @order = order
  end

  def total
    @order.products.pluck(:price).sum
  end
end
