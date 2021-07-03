class ChangeCartItemOrderItemNullToTrue < ActiveRecord::Migration[6.1]
  def change
    change_column :cart_items, :cart_id, :integer, null: true
  end
end
