# frozen_string_literal: true

class ProductsController < AdminController
  def new
    render :new, locals: { product: Product.new }
  end

  def create
    product = Product.new(product_params)
    if product.save
      redirect_to admin_root_path
    else
      render new_admin_product_path, alert: 'Could not save product'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :brand_id, :category_id)
  end
end
