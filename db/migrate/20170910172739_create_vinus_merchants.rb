class CreateVinusMerchants < ActiveRecord::Migration
  def change
    create_table :vinus_merchants do |t|
      t.string :name
    end
  end
end
