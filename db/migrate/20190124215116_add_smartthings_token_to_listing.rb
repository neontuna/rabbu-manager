class AddSmartthingsTokenToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :smartthings_token, :string
  end
end
