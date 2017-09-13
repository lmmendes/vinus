class CreateVinusProductsVinusVendors < ActiveRecord::Migration
  def change
    create_table :vinus_products_vinus_vendors do |t|
      t.integer :product_id, null: false
      t.integer :vendor_id, null: false
    end
    add_index :vinus_products_vinus_vendors, [:product_id, :vendor_id]
  end
end
