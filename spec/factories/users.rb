# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'email@test.com' }
    password { 'password123' }
  end
end
