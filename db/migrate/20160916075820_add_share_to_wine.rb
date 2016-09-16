class AddShareToWine < ActiveRecord::Migration
  def change
    add_reference :wines, :share, index: true, foreign_key: true
  end
end
