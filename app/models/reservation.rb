# == Schema Information
#
# Table name: reservations
#
#  id                          :bigint(8)        not null, primary key
#  listing_id                  :bigint(8)
#  start_date                  :date             not null
#  end_date                    :date             not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  automatic_checkout_complete :boolean          default(FALSE)
#  checkout_time               :time             not null
#

class Reservation < ApplicationRecord
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validates :start_date, :end_date, overlap: {
    scope: "listing_id",
    exclude_edges: ["start_date", "end_date"]
  }

  def end_date_after_start_date
    if end_date.present? && end_date <= start_date
      errors.add(:end_date, "cannot be before or the same as start date, McFly.")
    end
  end

  def self.pending_automatic_checkout
    includes(:listing).references(:listing).
    where(
      "(end_date + checkout_time) <= CURRENT_TIMESTAMP AT TIME ZONE listings.time_zone AND
        automatic_checkout_complete = false AND
        listings.automatic_servicing = true"
    )
  end
end
