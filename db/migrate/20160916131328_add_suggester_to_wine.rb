class AddSuggesterToWine < ActiveRecord::Migration
  def change
    add_column :wines, :suggester_id, :integer, index: true
    add_foreign_key :wines, :users, column: :suggester_id
  end
end
