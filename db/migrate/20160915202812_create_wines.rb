class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :name, null: false
      t.text :description
      t.integer :bottles, null: false
      t.integer :price

      t.timestamps null: false
    end
  end
end
