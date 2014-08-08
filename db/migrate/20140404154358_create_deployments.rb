class CreateDeployments < ActiveRecord::Migration
  def change
    create_table :deployments do |t|
      t.string :commit_sha
      t.string :tag
      t.string :server
      t.string :application

      t.timestamps
    end
  end
end
