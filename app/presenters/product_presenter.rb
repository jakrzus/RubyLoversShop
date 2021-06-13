# frozen_string_literal: true

class ProductPresenter
  def initialize(product)
    @product = product
  end

  def invalid?(attribute)
    errors.attribute_names.include? attribute
  end

  def errors_for(attribute)
    errors.messages[attribute].map(&:capitalize).join(', ') if invalid?(attribute)
  end

  def valid_class(attribute)
    ' is-invalid' if invalid?(attribute)
  end

  private

  def errors
    @product.errors
  end
end
