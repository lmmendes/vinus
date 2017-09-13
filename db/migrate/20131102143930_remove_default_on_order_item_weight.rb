class RemoveDefaultOnOrderItemWeight < ActiveRecord::Migration
  def up
    change_column_default :vinus_order_items, :weight, nil
  end

  def down
    change_column_default :vinus_order_items, :weight, 0.0
  end
end
