class CartItemsController < ApplicationController
  def update
    item = CartItem.find(params[:id])
    if item.update(item_params)
      redirect_to cart_path, notice: 'Product updated successfully'
    else
      redirect_to cart_path, alert: 'Product not updated successfully'
    end
  end

  private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end
end
