class AddIndexesToVinusProducts < ActiveRecord::Migration
  def change
    add_index :vinus_products, :parent_id
    add_index :vinus_products, :sku
    add_index :vinus_products, :product_category_id
    add_index :vinus_products, :permalink
  end
end
