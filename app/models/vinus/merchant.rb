module Vinus
  class Merchant < ActiveRecord::Base
    self.table_name = 'vinus_merchants'
    has_many :vendors, dependent: :destroy, class_name: 'Vinus::Vendor', inverse_of: :vendor
  end
end
