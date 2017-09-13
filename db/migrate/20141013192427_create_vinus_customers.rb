class CreateVinusCustomers < ActiveRecord::Migration
  def change
    create_table :vinus_customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :email
      t.string :phone
      t.string :mobile

      t.timestamps
    end
  end
end
