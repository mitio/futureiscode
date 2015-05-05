module AlphabeticalOrder
  extend ActiveSupport::Concern

  included do
    scope :in_alphabetical_order, -> { order(arel_table[:name].asc) }
  end
end
