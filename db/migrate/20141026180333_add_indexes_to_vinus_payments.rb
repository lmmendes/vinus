class AddIndexesToVinusPayments < ActiveRecord::Migration
  def change
    add_index :vinus_payments, :order_id
    add_index :vinus_payments, :parent_payment_id
  end
end
