class AddTimeZoneToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :time_zone, :string, null: false
  end
end
