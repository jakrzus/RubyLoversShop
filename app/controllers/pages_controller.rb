# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @pagy, products = pagy(Product.filtered(filter_params)
                      .includes(%i[brand category])
                      .with_attached_photos
                      .order(created_at: :desc))
    render :home, locals: { products: products }
  end

  private

  def filter_params
    params.require(:filter).permit(:category_id, :brand_id) if params[:commit]
  end
end
