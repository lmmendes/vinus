module Vinus
  class Package < ActiveRecord::Base
    self.table_name = 'vinus_packages'

    # An array of all the available statuses for an order
    STATUSES = %w(received shipped delivered).freeze

    # Set the status to building if we don't have a status
    after_initialize { self.status = STATUSES.first if status.blank? }

    belongs_to :vendor, class_name: 'Vinus::Vendor'
    belongs_to :order, class_name: 'Vinus::Order'

    has_many :order_items, -> (object) {
      joins('INNER JOIN vinus_products ON vinus_order_items.ordered_item_id = vinus_products.id AND ordered_item_type = "Vinus::Product"')
      .where('vinus_products.vendor_id' => object.vendor_id)
    }, through: :order

    # Return the number of items in the order?
    #
    # @return [Integer]
    def total_items
      order_items.inject(0) { |t, i| t + i.quantity }
    end

    # The total cost of the order
    #
    # @return [BigDecimal]
    def total_cost
      order.delivery_cost_price +
        order_items.inject(BigDecimal(0)) { |t, i| t + i.total_cost }
    end

    # Return the price for the order
    #
    # @return [BigDecimal]
    def profit
      total_before_tax - total_cost
    end

    # The total price of all items in the basket excluding delivery
    #
    # @return [BigDecimal]
    def items_sub_total
      order_items.inject(BigDecimal(0)) { |t, i| t + i.sub_total }
    end

    # The total price of the order before tax
    #
    # @return [BigDecimal]
    def total_before_tax
      order.delivery_price + items_sub_total
    end

    # The total amount of tax due on this order
    #
    # @return [BigDecimal]
    def tax
      order.delivery_tax_amount +
        order_items.inject(BigDecimal(0)) { |t, i| t + i.tax_amount }
    end

    # The total of the order including tax
    #
    # @return [BigDecimal]
    def total
      order.delivery_price +
        order.delivery_tax_amount +
        order_items.inject(BigDecimal(0)) { |t, i| t + i.total }
    end


  end
end
