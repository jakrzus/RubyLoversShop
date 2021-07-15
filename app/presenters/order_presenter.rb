# frozen_string_literal: true

class OrderPresenter
  def initialize(order)
    @order = order
  end

  def total
    @order.products.pluck(:price).sum
  end

  def created_at
    @order.created_at.strftime('%F %R')
  end
end
