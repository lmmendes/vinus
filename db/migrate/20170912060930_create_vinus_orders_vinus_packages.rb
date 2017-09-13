class CreateVinusOrdersVinusPackages < ActiveRecord::Migration
  def change
    create_table :vinus_orders_vinus_packages do |t|
      t.integer :order_id
      t.integer :package_id
    end
  end
end
