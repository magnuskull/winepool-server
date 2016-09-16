class RemoveShareFromWine < ActiveRecord::Migration
  def change
    remove_reference :wines, :share, index: true, foreign_key: true
  end
end
