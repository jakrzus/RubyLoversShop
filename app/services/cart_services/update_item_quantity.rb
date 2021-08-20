# frozen_string_literal: true

module CartServices
  class UpdateItemQuantity
    def call(user, item, params)
      return OpenStruct.new(success?: false, flash: 'You are not authorized') unless authorized?(user, item)
      return CartServices::RemoveItem.new.call(item, user) if params[:quantity].to_i.zero?

      if item.update!(params)
        OpenStruct.new(success?: true, flash: 'Item updated successfully')
      else
        OpenStruct.new(success?: false, flash: 'Could not update the item')
      end
    end

    private

    def authorized?(user, item)
      user.cart.cart_items.include?(item)
    end
  end
end
