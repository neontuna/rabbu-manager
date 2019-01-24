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

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
