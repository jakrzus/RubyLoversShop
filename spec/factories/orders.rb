# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user { User.all.sample || FactoryBot.create(:user) }
    before(:create) do |order|
      create_list :product, 5
      order.cart_items = build_list(:cart_item, 5)
    end

    trait :big_id do
      sequence :id, 9_999_999
    end
    trait :random_state do
      state { Order::STATES.sample }
    end
  end
end
