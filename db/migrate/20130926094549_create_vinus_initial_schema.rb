class CreateVinusInitialSchema < ActiveRecord::Migration
  def up
    create_table 'vinus_countries' do |t|
      t.string  'name'
      t.string  'code2'
      t.string  'code3'
      t.string  'continent'
      t.string  'tld'
      t.string  'currency'
      t.boolean 'eu_member', default: false
    end

    create_table 'vinus_delivery_service_prices' do |t|
      t.integer  'delivery_service_id'
      t.string   'code'
      t.decimal  'price',               precision: 8, scale: 2
      t.decimal  'cost_price',          precision: 8, scale: 2
      t.integer  'tax_rate_id'
      t.decimal  'min_weight',          precision: 8, scale: 2
      t.decimal  'max_weight',          precision: 8, scale: 2
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.text     'country_ids'
    end

    create_table 'vinus_delivery_services' do |t|
      t.string   'name'
      t.string   'code'
      t.boolean  'default',      default: false
      t.boolean  'active',       default: true
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string   'courier'
      t.string   'tracking_url'
    end

    create_table 'vinus_order_items' do |t|
      t.integer  'order_id'
      t.integer  'ordered_item_id'
      t.string   'ordered_item_type'
      t.integer  'quantity', default: 1
      t.decimal  'unit_price',        precision: 8, scale: 2
      t.decimal  'unit_cost_price',   precision: 8, scale: 2
      t.decimal  'tax_amount',        precision: 8, scale: 2
      t.decimal  'tax_rate',          precision: 8, scale: 2
      t.decimal  'weight',            precision: 8, scale: 3, default: 0.0
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    create_table 'vinus_orders' do |t|
      t.string   'token'
      t.string   'first_name'
      t.string   'last_name'
      t.string   'company'
      t.string   'billing_address1'
      t.string   'billing_address2'
      t.string   'billing_address3'
      t.string   'billing_address4'
      t.string   'billing_postcode'
      t.integer  'billing_country_id'
      t.string   'email_address'
      t.string   'phone_number'
      t.string   'status'
      t.datetime 'received_at'
      t.datetime 'accepted_at'
      t.datetime 'shipped_at'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer  'delivery_service_id'
      t.decimal  'delivery_price',            precision: 8, scale: 2
      t.decimal  'delivery_cost_price',       precision: 8, scale: 2
      t.decimal  'delivery_tax_rate',         precision: 8, scale: 2
      t.decimal  'delivery_tax_amount',       precision: 8, scale: 2
      t.datetime 'paid_at'
      t.integer  'accepted_by'
      t.integer  'shipped_by'
      t.string   'consignment_number'
      t.datetime 'rejected_at'
      t.integer  'rejected_by'
      t.string   'ip_address'
      t.string   'payment_reference'
      t.string   'payment_method'
      t.text     'notes'
      t.boolean  'separate_delivery_address', default: false
      t.string   'delivery_name'
      t.string   'delivery_address1'
      t.string   'delivery_address2'
      t.string   'delivery_address3'
      t.string   'delivery_address4'
      t.string   'delivery_postcode'
      t.integer  'delivery_country_id'
    end

    create_table 'vinus_product_attributes' do |t|
      t.integer  'product_id'
      t.string   'key'
      t.string   'value'
      t.integer  'position',   default: 1
      t.boolean  'searchable', default: true
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.boolean  'public', default: true
    end

    create_table 'vinus_product_categories' do |t|
      t.string   'name'
      t.string   'permalink'
      t.text     'description'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    create_table 'vinus_products' do |t|
      t.integer  'parent_id'
      t.integer  'product_category_id'
      t.string   'name'
      t.string   'sku'
      t.string   'permalink'
      t.text     'description'
      t.text     'short_description'
      t.boolean  'active',                                      default: true
      t.decimal  'weight',              precision: 8, scale: 3, default: 0.0
      t.decimal  'price',               precision: 8, scale: 2, default: 0.0
      t.decimal  'cost_price',          precision: 8, scale: 2, default: 0.0
      t.integer  'tax_rate_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.boolean  'featured', default: false
      t.text     'in_the_box'
      t.boolean  'stock_control',                               default: true
      t.boolean  'default',                                     default: false
    end

    create_table 'vinus_settings' do |t|
      t.string 'key'
      t.string 'value'
      t.string 'value_type'
    end

    create_table 'vinus_stock_level_adjustments' do |t|
      t.integer  'item_id'
      t.string   'item_type'
      t.string   'description'
      t.integer  'adjustment', default: 0
      t.string   'parent_type'
      t.integer  'parent_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    create_table 'vinus_tax_rates' do |t|
      t.string   'name'
      t.decimal  'rate', precision: 8, scale: 2
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.text     'country_ids'
    end

    create_table 'vinus_merchants' do |t|
      t.integer 'id'
      t.string 'name'
      t.string 'address1'
      t.string 'address2'
      t.string 'address3'
      t.string 'address4'
      t.string 'postcode'
      t.integer 'country_id'
      t.decimal 'commision', precision: 8, scale: 2, default: 0.0
      t.decimal  'weight', precision: 8, scale: 3, default: 0.0
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    create_table 'vinus_users' do |t|
      t.integer 'merchant_id'
      t.string   'first_name'
      t.string   'last_name'
      t.string   'email_address'
      t.string   'password_digest'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end
  end

  def down
    [
      :users, :tax_rates, :stock_level_adjustments, :settings, :products,
      :product_categories, :product_attributes, :orders, :order_items,
      :delivery_services, :delivery_service_prices, :countries
    ].each do |table|
      drop_table "vinus_#{table}"
    end
  end
end
