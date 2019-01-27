class RemoveDevices < ActiveRecord::Migration[5.2]
  def change
    drop_table :devices
  end
end
