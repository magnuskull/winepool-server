module V1
  class WineResource < BaseResource

    attribute :name
    attribute :description
    attribute :bottles
    attribute :price
    attribute :fulfilled, delegate: :is_fulfilled?

    has_one :suggester
    has_many :shares

    class << self
      def creatable_fields(context)
        [:name, :description, :bottles, :price, :suggester]
      end
      alias_method :updatable_fields, :creatable_fields
    end

  end
end
