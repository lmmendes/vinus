class AddIndexesToVinusOrderItems < ActiveRecord::Migration
  def change
    add_index :vinus_order_items, [:ordered_item_id, :ordered_item_type], name: 'index_vinus_order_items_ordered_item'
    add_index :vinus_order_items, :order_id
  end
end
