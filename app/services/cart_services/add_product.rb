# frozen_string_literal: true

module CartServices
  class AddProduct
    def call(cart, product)
      if cart_include_product? cart, product
        OpenStruct.new({ success?: false, payload: { error: 'Product allready in the cart' } })
      elsif item_saved? cart, product
        OpenStruct.new({ success?: true, payload: @item })
      else
        OpenStruct.new({ success?: false, payload: { error: 'Could not add item', errors: @item&.errors } })
      end
    end

    private

    def cart_include_product?(cart, product)
      cart.cart_items.map(&:product).include? product
    end

    def item_saved?(cart, product)
      @item = cart.cart_items.build product_id: product.id
      @item.save
    end
  end
end
