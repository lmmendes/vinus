class AddAddressTypeToVinusTaxRates < ActiveRecord::Migration
  def change
    add_column :vinus_tax_rates, :address_type, :string
  end
end
