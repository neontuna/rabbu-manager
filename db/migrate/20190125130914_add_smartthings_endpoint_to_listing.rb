class AddSmartthingsEndpointToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :smartthings_endpoint, :string
  end
end
