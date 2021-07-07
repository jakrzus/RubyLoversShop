# frozen_string_literal: true

STATES = %i[new failed completed].freeze

FactoryBot.define do
  factory :order do
    user { User.all.sample }
    state { STATES.sample }
    before(:create) do |order|
      order.cart_items = FactoryBot.build_list(:cart_item, 5)
    end
  end
end
