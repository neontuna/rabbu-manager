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

  enum hardware_type: { hardware_unknown: 0, st_switch: 1, st_lock: 2, st_thermostat: 3 }
end
