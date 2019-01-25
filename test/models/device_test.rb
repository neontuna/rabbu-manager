# == Schema Information
#
# Table name: devices
#
#  id             :bigint(8)        not null, primary key
#  listing_id     :bigint(8)
#  status         :string           default("0"), not null
#  hardware_type  :integer          default("hardware_unknown"), not null
#  meta           :jsonb
#  display_name   :string
#  smartthings_id :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
