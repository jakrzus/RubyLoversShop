# frozen_string_literal: true

namespace :one_time do
  desc 'create shipments for allready existing orders'
  task create_shipments: :environment do
    Order.find_each(&:create_shipment)
  end

  desc 'Create products for allready existing orders'
  task create_products: :environment do
    Order.find_each(&:create_payment)
  end

  desc 'add description for allready existing seeded products'
  task create_products_descriptions: :environment do
    Product.find_each do |product|
      product.description = Faker::Lorem.paragraphs(number: 10).join
      product.save!
    end
  end
end
