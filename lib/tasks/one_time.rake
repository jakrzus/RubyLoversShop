# frozen_string_literal: true

namespace :one_time do
  desc 'create a shipment for allready existing orders'
  task create_shipments: :environment do
    Order.find_each(&:create_shipment)
  end
end
