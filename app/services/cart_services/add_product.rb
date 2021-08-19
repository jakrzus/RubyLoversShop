# frozen_string_literal: true

module CartServices
  class AddProduct
    def call(cart, product, quantity = 1)
      if cart_include_product?(cart, product)
        append_quantity(cart, product, quantity)
      else
        create_item(cart, product, quantity)
      end
    end

    private

    def cart_include_product?(cart, product)
      cart.cart_items.map(&:product).include?(product)
    end

    def create_item(cart, product, quantity)
      item = cart.cart_items.build(product_id: product.id, quantity: quantity)

      save_item(item)
    end

    def append_quantity(cart, product, quantity)
      item = cart.cart_items.find_by(product_id: product)
      item.quantity += quantity

      save_item(item)
    end

    def  save_item(item)
      if item.save
        OpenStruct.new({ success?: true, payload: item })
      else
        OpenStruct.new({ success?: false, payload: { error: 'Could not add item', errors: item&.errors } })
      end
    end
  end
end
