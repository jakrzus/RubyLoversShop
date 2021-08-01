# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product#{n}" }
    price { '999.99' }
    description { lorem }
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
def lorem
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit,
  sed do eiusmod tempor incididunt ut labore et dolore magna
  aliqua. Ut enim ad minim veniam, quis nostrud exercitation
  ullamco laboris nisi ut aliquip ex ea commodo consequat.
  Duis aute irure dolor in reprehenderit in voluptate velit
  esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
  occaecat cupidatat non proident, sunt in culpa qui officia
  deserunt mollit anim id est laborum.'
end
