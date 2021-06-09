# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product#{n}" }
    price { '999.99' }
    category { Category.any? ? Category.all.sample : create(:category) }
    brand { Brand.any? ? Brand.all.sample : create(:brand) }
    trait :with_photo do
      after(:create) do |product|
        file = File.open(Rails.root.join('spec/support/watch.webp'))
        product.photos.attach(io: file, filename: 'watch.webp', content_type: 'image/webp')
      end
    end
  end
end
