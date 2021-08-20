# frozen_string_literal: true

class CartPresenter
  def initialize(cart)
    @cart = cart
  end

  def total_price
    items = @cart.cart_items
    items.map { |item| CartItemPresenter.new(item).total_price }.sum
  end
end
