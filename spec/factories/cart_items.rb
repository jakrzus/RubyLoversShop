# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item do
    before { FactoryBot.create_list(:product, 5) if Product.count < 5 }

    product { Product.all.sample || FactoryBot.create(:product) }
  end
end
