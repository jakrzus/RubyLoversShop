# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @categories_select_params = Category.select_params
    @brands_select_params = Brand.select_params
    @products = Product.filtered(filter_params)
  end

  private

  def filter_params
    params.require(:filter).permit(:category_id, :brand_id) if params[:commit]
  end
end
