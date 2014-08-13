class AddPasswordFieldsToUsers < ActiveRecord::Migration
  def change
    add_column    :users, :password_salt, :string
    rename_column :users, :password, :password_hash
  end
end
