# == Schema Information
#
# Table name: listings
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  address    :string
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Listing < ApplicationRecord
  belongs_to :user
  has_many :devices
end
