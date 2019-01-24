class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.references :listing
      t.integer :status, null: false, default: 0
      t.integer :type, null: false, default: 0
      t.jsonb :meta

      t.timestamps
    end
  end
end
