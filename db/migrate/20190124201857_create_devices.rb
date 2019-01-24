class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.references :listing
      t.integer :status, null: false, default: 0
      t.integer :hardware_type, null: false, default: 0
      t.jsonb :meta
      t.string :display_name
      t.string :smartthings_id

      t.timestamps
    end
  end
end
