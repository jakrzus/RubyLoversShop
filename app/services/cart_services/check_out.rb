# frozen_string_literal: true

module CartServices
  class CheckOut
    def call(user)
      return OpenStruct.new(status: :unfinished) if unfinished_checkout? user

      order = user.orders.build
      ActiveRecord::Base.transaction do
        transfer_items_from_cart user.cart, order
        order.save!
      end
      OpenStruct.new(status: :created, payload: order)
    rescue StandardError => e
      OpenStruct.new(status: :failed, error: e.message)
    end

    private

    def transfer_items_from_cart(cart, order)
      cart.cart_items.each do |item|
        order.cart_items << item
        item.cart_id = nil
        item.save!
      end
    end

    def unfinished_checkout?(user)
      user.orders.find_by(state: :new).present?
    end
  end
end
