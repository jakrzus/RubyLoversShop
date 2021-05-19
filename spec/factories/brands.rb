# frozen_string_literal: true

FactoryBot.define do
  factory :brand do
    name { Faker::Vehicle.unique.make }
  end
end
