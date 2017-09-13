class AddIndexesToVinusProductCategories < ActiveRecord::Migration
  def change
    add_index :vinus_product_categories, :permalink
  end
end
