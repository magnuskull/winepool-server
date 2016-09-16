class Share < ActiveRecord::Base

  belongs_to :wine
  belongs_to :user

  validates_numericality_of :amount

end
