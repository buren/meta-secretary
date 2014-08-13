class AddMetaAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :meta_access_token, :string
  end
end
