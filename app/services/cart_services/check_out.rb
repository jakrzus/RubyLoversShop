# frozen_string_literal: true

module CartServices
  class CheckOut
    def call(cart, order)
      order.cart_items = cart.cart_items
      if order.save
        remove_items_from_cart order
        OpenStruct.new(succes?: true, payload: order)
      else
        OpenStruct.new(succes?: false, payload: order)
      end
    end

    private

    def remove_items_from_cart(order)
      order.cart_items.each do |item|
        item.cart_id = nil
        item.save
      end
    end
  end
end
