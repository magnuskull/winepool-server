class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :amount, null: false

      t.timestamps null: false
    end
  end
end
