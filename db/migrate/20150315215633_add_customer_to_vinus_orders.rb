class AddCustomerToVinusOrders < ActiveRecord::Migration
  def change
    add_column :vinus_orders, :customer_id, :integer
  end
end
