# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Vehicle.car_type }
  end
end
