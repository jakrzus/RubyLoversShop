# frozen_string_literal: true

class CheckOutsController < ApplicationController
  before_action :authenticate_user!

  def new
    order = current_user.orders.where(state: :new).last
    render :new, locals: { order: order }
  end
end
