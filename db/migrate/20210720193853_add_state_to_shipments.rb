class AddStateToShipments < ActiveRecord::Migration[6.1]
  def change
    add_column :shipments, :state, :string
  end
end
