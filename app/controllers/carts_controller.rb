class CartsController < ApplicationController
  before_action :authenticate_user!
  def show
    render :show, locals: { items: current_user.cart.cart_items }
  end
end
