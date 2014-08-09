class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_token, :striong
    add_index :users, :remember_token
  end
end
