class User < ActiveRecord::Base

  has_many :shares
  has_many :wines, through: :shares
  has_many :suggestions, class_name: 'Wine', foreign_key: :suggester_id

  validates_presence_of :name
  validates :email_address, presence: true, uniqueness: {case_sensitive: false}
  validates :mobile_phone_number, uniqueness: true

end
