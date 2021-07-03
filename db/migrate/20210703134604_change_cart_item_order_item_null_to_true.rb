class ChangeCartItemOrderItemNullToTrue < ActiveRecord::Migration[6.1]
  def up
    change_column :cart_items, :cart_id, :bigint, null: true
  end
  def down
    change_column :cart_items, :cart_id, :bigint, null: false
  end
end
