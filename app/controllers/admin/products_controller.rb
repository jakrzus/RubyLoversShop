# frozen_string_literal: true

module Admin
  class ProductsController < AdminController
    def new
      render :new, locals: { product: Product.new }
    end

    def create
      product = Product.new(product_params)
      if product.save
        redirect_to root_path, notice: 'Product was successfully created'
      else
        flash.now[:alert] = 'Product was not created'
        render :new, locals: { product: Product.new(product_params) }
      end
    end

    private

    def product_params
      params.require(:product).permit(:name, :price, :brand_id, :category_id, photos: [])
    end
  end
end
