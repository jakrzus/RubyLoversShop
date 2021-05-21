# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @products = Product.where(query_params[:filter])
    @categories_select_params = Category.select_params
  end
end

private

def query_params
  params.permit(filter: [:category_id])
end
