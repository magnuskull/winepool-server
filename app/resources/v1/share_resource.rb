module V1
  class ShareResource < BaseResource
    attribute :amount
    has_one :user
    has_one :wine

    class << self
      def creatable_fields(context)
        [:amount, :user, :wine]
      end
      alias_method :updatable_fields, :creatable_fields
    end

  end
end
