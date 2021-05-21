# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Vehicle.unique.car_type }
  end
end
