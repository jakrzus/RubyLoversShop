class CreateShimpentObjects < ActiveRecord::Migration[6.1]
  def up
    Order.find_each(&:create_shipment)
  end

  def down
    Order.find_each { |order| order.shipment.destroy }
  end
end
