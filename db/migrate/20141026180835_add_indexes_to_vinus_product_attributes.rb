class AddIndexesToVinusProductAttributes < ActiveRecord::Migration
  def change
    add_index :vinus_product_attributes, :product_id
    add_index :vinus_product_attributes, :key
    add_index :vinus_product_attributes, :position
  end
end
