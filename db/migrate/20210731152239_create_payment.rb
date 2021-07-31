class CreatePayment < ActiveRecord::Migration[6.1]
  def up
    Order.find_each(&:create_payment)
  end

  def down
    Order.find_each { |order| order.payment.destroy }
  end
end
