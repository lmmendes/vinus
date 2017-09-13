module Vinus
  module ViewHelpers
    # Returns currency values with the currency unit as specified by the Vinus settings
    def number_to_currency(number, options = {})
      options[:unit] ||= Vinus.settings.currency_unit
      super
    end

    # Returns a number of kilograms with the appropriate suffix
    def number_to_weight(kg)
      "#{kg}#{t('vinus.helpers.number_to_weight.kg', default: 'kg')}"
    end
  end
end
