# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item do
    product { Product.all.sample || create(:product) }
  end
end
