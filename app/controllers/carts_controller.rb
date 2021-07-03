# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  def show
    render :show, locals: { items: cart.cart_items }
  end

  def add_product
    product = Product.find params[:id]
    add_product = CartServices::AddProduct.new.call cart, product
    if add_product.success?
      redirect_to root_path, notice: 'Product added successfully'
    else
      redirect_back fallback_location: root_path, alert: add_product.payload[:error]
    end
  end

  def destroy
    items = current_user.cart.cart_items
    if items.destroy_all
      render :show, locals: { items: current_user.cart.cart_items }, notice: 'All products has been deleted'
    else
      render :show, locals: { items: current_user.cart.cart_items }, allert: 'Ups! Something went wrong'
    end
  end

  def checkout
    create_new_order unless unfinished_checkout?
  end

  private

  def cart
    @cart ||= current_user.cart
  end

  def unfinished_checkout?
    if current_user.orders.find_by(state: :new).present?
      redirect_to new_check_out_path, alert: 'You must finish check out'
    end
  end

  def create_new_order
    order = current_user.orders.build
    response = CartServices::CheckOut.new.call cart, order
    if response.success?
      redirect_to new_check_out_path, notice: 'Order has been created'
    else
      redirect_back fallback_location: root_path, alert: response.payload.errors.full_messages
    end
  end
end
