# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @products = Product.where(query_params[:filter])
    @categories = Category.all
  end
end

private

def query_params
  params.permit(filter: [:category_id])
end
