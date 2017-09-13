class AddVendorIdToProducts < ActiveRecord::Migration
  def change
    add_column :vinus_products, :vendor_id, :integer
    add_index(:vinus_products, :vendor_id)
  end
end
