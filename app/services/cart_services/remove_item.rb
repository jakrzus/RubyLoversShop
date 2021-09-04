# frozen_string_literal: true

module CartServices
  class RemoveItem
    def call(item, user)
      cart_user = item.user
      return OpenStruct.new(success?: false, flash: 'Cart does not belong to this user!') if user != cart_user

      if item.destroy
        OpenStruct.new(success?: true, flash: 'Item removed successfully')
      else
        OpenStruct.new(success?: false, flash: 'Item not removed successfully')
      end
    end
  end
end
