class AddIndexesToVinusStockLevelAdjustments < ActiveRecord::Migration
  def change
    add_index :vinus_stock_level_adjustments, [:item_id, :item_type], name: 'index_vinus_stock_level_adjustments_items'
    add_index :vinus_stock_level_adjustments, [:parent_id, :parent_type], name: 'index_vinus_stock_level_adjustments_parent'
  end
end
