class AddDetailsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :email_address, :string
    add_column :users, :mobile_phone_number, :string
    change_column_null :users, :email_address, false

    add_index :users, :email_address, unique: true
    add_index :users, :mobile_phone_number, unique: true
  end

  def down
    remove_column :users, :email_address, :string
    remove_column :users, :mobile_phone_number, :string
  end
end
