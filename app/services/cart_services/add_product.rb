# frozen_string_literal: true

module CartServices
  class AddProduct
    def call(cart, product)
      if cart_include_product? cart, product
        OpenStruct.new({ success?: false, payload: { error: 'Product allready in the cart' } })
      else save_item cart, product
      end
    end

    private

    def cart_include_product?(cart, product)
      cart.cart_items.map(&:product).include? product
    end

    def save_item(cart, product)
      item = cart.cart_items.build product_id: product.id

      if item.save
        OpenStruct.new({ success?: true, payload: item })
      else
        OpenStruct.new({ success?: false, payload: { error: 'Could not add item', errors: item&.errors } })
      end
    end
  end
end
