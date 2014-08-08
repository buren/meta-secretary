class AddIpAddressToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :ip_address, :string
  end
end
