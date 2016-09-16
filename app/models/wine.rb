class Wine < ActiveRecord::Base

  has_many :shares
  has_many :users, through: :shares
  belongs_to :suggester, class_name: 'User'

  validates_presence_of :name
  validates_numericality_of :bottles
  validates_numericality_of :price, allow_nil: true

end
