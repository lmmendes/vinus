class CreateVinusPackages < ActiveRecord::Migration
  def change
    create_table :vinus_packages do |t|
      t.integer :order_id
      t.integer :vendor_id
      t.string   :status
      t.datetime :shipped_at
      t.string   :consignment_number
      t.string :notes
    end
  end
end
