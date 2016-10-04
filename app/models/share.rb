class Share < ActiveRecord::Base

  belongs_to :wine
  belongs_to :user

  validates_numericality_of :amount, greater_than_or_equal_to: 1
  validate :_amount_does_not_exceed_available_bottles

  validates_presence_of :wine
  validates_presence_of :user

  def _amount_does_not_exceed_available_bottles
    return unless wine

    if wine.shares.sum(:amount) + amount > wine.bottles

      errors.add :amount, "not enough bottles available"
    end

  end

end
