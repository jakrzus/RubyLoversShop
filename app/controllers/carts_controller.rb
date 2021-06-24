# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!, :set_cart
  def show
    render :show, locals: { items: @cart.cart_items }
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
