# == Schema Information
#
# Table name: reservations
#
#  id         :bigint(8)        not null, primary key
#  listing_id :bigint(8)
#  start_date :date             not null
#  end_date   :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
