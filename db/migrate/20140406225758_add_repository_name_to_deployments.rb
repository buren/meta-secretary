class AddRepositoryNameToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :repository_name, :string
  end
end
