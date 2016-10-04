module V1
  class UserResource < BaseResource

    attribute :name
    attribute :email_address
    attribute :mobile_phone_number

    has_many :wines
    has_many :shares

    class << self
      def creatable_fields(context)
        [:name, :email_address, :mobile_phone_number]
      end
      alias_method :updatable_fields, :creatable_fields
    end
  end
end
