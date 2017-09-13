class AddIndexesToVinusUsers < ActiveRecord::Migration
  def change
    add_index :vinus_users, :email_address
  end
end
