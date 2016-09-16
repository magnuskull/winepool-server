class AddWineToShare < ActiveRecord::Migration
  def change
    add_reference :shares, :wine, index: true, foreign_key: true
  end
end
