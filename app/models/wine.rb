class Wine < ActiveRecord::Base

  validates_presence_of :name
  validates_numericality_of :bottles
  validates_numericality_of :price, allow_nil: true

end
