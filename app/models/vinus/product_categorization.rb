module Vinus
  class ProductCategorization < ActiveRecord::Base
    self.table_name = 'vinus_product_categorizations'

    # Links back
    belongs_to :product, class_name: 'Vinus::Product'
    belongs_to :product_category, class_name: 'Vinus::ProductCategory'

    # Validations
    validates_presence_of :product, :product_category
  end
end
