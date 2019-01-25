# == Schema Information
#
# Table name: listings
#
#  id                   :bigint(8)        not null, primary key
#  title                :string
#  address              :string
#  user_id              :bigint(8)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  smartthings_token    :string
#  smartthings_endpoint :string
#

require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
