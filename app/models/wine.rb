class Wine < ActiveRecord::Base

  has_many :shares

  has_many :users, through: :shares

  belongs_to :suggester, class_name: 'User'

  validates_presence_of :name

  validates_presence_of :suggester

  validates_numericality_of :bottles

  validates_numericality_of :price, allow_nil: true

  validate :_suggester_has_not_changed

  def _suggester_has_not_changed
    return unless persisted?

    if changes.key?("suggester_id")
      errors.add :suggester, "cannot be changed"
    end
  end

  def is_fulfilled?
    shares.sum(:amount) == bottles
  end

end
