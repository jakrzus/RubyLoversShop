# frozen_string_literal: true

class ProductsController < ApplicationController
  def show
    product = Product.find(params[:id])
    respond_to do |format|
      format.html do
        render :show, locals: { product: product, product_presenter: ProductPresenter.new(product) }
      end
      format.json do
        render json: product
      end
    end
  end
end
