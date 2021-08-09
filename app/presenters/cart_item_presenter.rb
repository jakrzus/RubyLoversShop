# frozen_string_literal: true

class CartItemPresenter
  def initialize(item)
    @item = item
  end

  def price
    @item.product.price
  end

  def total_price
    @item.product.price * @item.quantity
  end

  def name
    @item.product.name
  end
end
