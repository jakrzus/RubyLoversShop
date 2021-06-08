# frozen_string_literal: true

module Admin
  class PagesController < AdminController
    def dashboard
      render :dashboard, locals: { products: Product.all }
    end
  end
end
