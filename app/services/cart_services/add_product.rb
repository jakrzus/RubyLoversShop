# frozen_string_literal: true

module CartServices
  class AddProduct
    def call(cart, product)
      if cart.cart_items.map(&:product).include? product
        OpenStruct.new({ success?: false, payload: { error: 'Product allready in the cart' } })
      else
        item = cart.cart_items.build product_id: product.id
        if item.save
          OpenStruct.new({ success?: true, payload: item })
        else
          OpenStruct.new({ success?: false, payload: { error: 'Could not add item', errors: item&.errors } })
        end
      end
    end
  end
end
