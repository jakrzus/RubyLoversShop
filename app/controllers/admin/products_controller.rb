# frozen_string_literal: true

module Admin
  class ProductsController < AdminController
    def new
      product = Product.new
      render :new, locals: { product: product, product_presenter: ProductPresenter.new(product) }
    end

    def create
      product = Product.new(product_params)
      if product.save
        redirect_to root_path, notice: 'Product was successfully created'
      else
        render :new, locals: { product: product, product_presenter: ProductPresenter.new(product) }
      end
    end

    private

    def product_params
      params.require(:product).permit(:name, :price, :brand_id, :category_id, photos: [])
    end
  end
end
