class AddIndexesToVinusSettings < ActiveRecord::Migration
  def change
    add_index :vinus_settings, :key
  end
end
