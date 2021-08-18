class CartItemsController < ApplicationController
  def update
    item = CartItem.find(params[:id])
    response = CartServices::UpdateItemQuantity.new.call(current_user, item, item_params)
    if response.success?
      redirect_to cart_path, notice: response.flash
    else
      redirect_to cart_path, alert: response.flash
    end
  end

  private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end
end
