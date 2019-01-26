class AddCheckOutCompleteToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :automatic_check_out_complete, :boolean, default: false
    add_column :listings, :automatic_servicing, :boolean, default: false
  end
end
