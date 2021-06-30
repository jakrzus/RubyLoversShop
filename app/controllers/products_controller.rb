# frozen_string_literal: true

class ProductsController < ApplicationController
  def show
    product = Product.find(params[:id])
    render :show, locals: { product: product, product_presenter: ProductPresenter.new(product) }
  end
end
