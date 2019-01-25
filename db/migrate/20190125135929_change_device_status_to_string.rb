class ChangeDeviceStatusToString < ActiveRecord::Migration[5.2]
  def change
    change_column :devices, :status, :string
  end
end
