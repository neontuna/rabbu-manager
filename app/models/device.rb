# == Schema Information
#
# Table name: devices
#
#  id         :bigint(8)        not null, primary key
#  listing_id :bigint(8)
#  status     :integer          default(0), not null
#  type       :integer          default(0), not null
#  meta       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Device < ApplicationRecord
  enum status: { unknown: 0, on: 1, off: 2 }
  enum type: { unknown: 0, light: 1, lock: 2, thermostat: 3 }
end
