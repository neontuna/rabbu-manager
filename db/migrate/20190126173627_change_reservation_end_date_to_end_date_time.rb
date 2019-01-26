class ChangeReservationEndDateToEndDateTime < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :checkout_time, :time, null: false
    rename_column :reservations, :automatic_check_out_complete, :automatic_checkout_complete
  end
end
