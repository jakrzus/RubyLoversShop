# frozen_string_literal: true

class CartItemsController < ApplicationController
  def update
    item = CartItem.find(params[:id])
    begin
      response = CartServices::UpdateItemQuantity.new.call(current_user, item, item_params)
    rescue StandardError => e
      redirect_to cart_path, alert: e.message
    end
    set_flash(flash, response)
    redirect_to cart_path
  end

  def destroy
    item = CartItem.find(params[:id])
    response = CartServices::RemoveItem.new.call(item, current_user)
    set_flash(flash, response)
    redirect_to cart_path
  end

  private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end

  def set_flash(flash, response)
    if response.success?
      flash[:notice] = response.flash
    else
      flash[:alert] = response.flash
    end
  end
end
