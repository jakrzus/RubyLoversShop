# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!, :set_cart
  def show
    render :show, locals: { items: @cart.cart_items }
  end

  def add_product
    product = Product.find(params[:id])
    add_product = CartServices::AddProduct.new.call @cart, product
    if add_product.success?
      redirect_to root_path, notice: 'Product added successfully'
    else
      redirect_back fallback_location: root_path, alert: add_product.payload[:error]
    end
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
