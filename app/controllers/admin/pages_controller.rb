# frozen_string_literal: true

module Admin
  class PagesController < AdminController
    def dashboard
      render :dashboard,
             locals: { products: Product.filtered(filter_params).includes(%i[brand category photos_attachments]) }
    end

    private

    def filter_params
      params.require(:filter).permit(:category_id, :brand_id) if params[:commit]
    end
  end
end
