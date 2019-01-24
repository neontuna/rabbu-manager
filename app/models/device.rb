# == Schema Information
#
# Table name: devices
#
#  id             :bigint(8)        not null, primary key
#  listing_id     :bigint(8)
#  status         :integer          default("status_unknown"), not null
#  hardware_type  :integer          default("hardware_unknown"), not null
#  meta           :jsonb
#  display_name   :string
#  smartthings_id :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Device < ApplicationRecord
  belongs_to :listing

  enum status: { status_unknown: 0, on: 1, off: 2 }
  enum hardware_type: { hardware_unknown: 0, light: 1, smart_lock: 2, thermostat: 3 }
end
