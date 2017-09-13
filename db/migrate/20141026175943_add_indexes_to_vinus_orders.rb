class AddIndexesToVinusOrders < ActiveRecord::Migration
  def change
    add_index :vinus_orders, :token
    add_index :vinus_orders, :delivery_service_id
    add_index :vinus_orders, :received_at
  end
end
