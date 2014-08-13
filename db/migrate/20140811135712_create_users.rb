class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_access_token
      t.string :github_owner_name
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
