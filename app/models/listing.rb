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
#  time_zone            :string           not null
#

class Listing < ApplicationRecord
  validates :title, presence: true
  validates :time_zone, presence: true

  belongs_to :user
  has_many :devices, dependent: :destroy
  has_many :reservations, dependent: :destroy

  def save_smartthings_connection(callback_code)
    smartthings = Services::Smartthings.new(self.id)
    token = smartthings.auth_token(callback_code)

    update!(
      smartthings_token: token,
      smartthings_endpoint: smartthings.endpoint(token)
    )
  end

  def update_devices
    Services::Smartthings.new(self.id).update_devices_for_listing
  end
end
