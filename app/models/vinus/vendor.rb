module Vinus
  class Vendor < ActiveRecord::Base
    self.table_name = 'vinus_vendors'

    # The merchant which this vendor should be linked to
    #
    # @return [Vinus::Merchant]
    belongs_to :merchant, class_name: 'Vinus::Merchant'

    # Validations
    validates :name, presence: true
    validates :permalink, presence: true, uniqueness: true, permalink: true

    # Before validation, set the permalink if we don't already have one
    before_validation { self.permalink = name.parameterize if permalink.blank? && name.is_a?(String) }

    # Localisations
    translates :name, :permalink, :description
    scope :ordered, -> { includes(:translations).order(:name) }
  end
end
