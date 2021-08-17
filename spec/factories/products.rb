# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product#{n}" }
    price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    description { Faker::Lorem.sentences(number: 20).join(' ') }
    category { Category.any? ? Category.all.sample : create(:category) }
    brand { Brand.any? ? Brand.all.sample : create(:brand) }
    trait :with_photo do
      after(:create) do |product|
        file = File.open(Rails.root.join('spec/support/watch.webp'))
        product.photos.attach(io: file, filename: 'watch.webp', content_type: 'image/webp')
      end
    end
    trait :without_name do
      name { '' }
    end
  end
end
