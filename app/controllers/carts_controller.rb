# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  def show
    render :show, locals: { cart_presenter: CartPresenter.new(cart), items: cart.cart_items.includes(:product) }
  end

  def add_product
    product = Product.find params[:id]
    add_product = CartServices::AddProduct.new.call cart, product, quantity
    if add_product.success?
      redirect_to root_path, notice: 'Product added successfully'
    else
      redirect_back fallback_location: root_path, alert: add_product.payload[:error]
    end
  end

  def destroy
    items = current_user.cart.cart_items
    if items.destroy_all
      render :show, locals: { cart_presenter: CartPresenter.new(cart), items: current_user.cart.cart_items },
                    notice: 'All products has been deleted'
    else
      render :show, locals: { cart_presenter: CartPresenter.new(cart), items: current_user.cart.cart_items },
                    allert: 'Ups! Something went wrong'
    end
  end

  def checkout
    response = CartServices::CheckOut.new.call current_user
    case response.status
    when :unfinished
      redirect_to new_check_out_path, alert: 'You must finish check out'
    when :created
      redirect_to new_check_out_path, notice: 'Order has been created'
    else
      redirect_back fallback_location: root_path, alert: 'Could not create new order'
      logger.debug response.error
    end
  end

  private

  def cart
    @cart ||= current_user.cart
  end

  def quantity
    params[:quantity].to_i
  end
end
