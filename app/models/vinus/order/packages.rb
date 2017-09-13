module Vinus
  class Order < ActiveRecord::Base
    def package_items!
      self.vendors.each do |vendor|
        package = self.packages.build(vendor: vendor)
        package.save!
      end
    end
  end
end
