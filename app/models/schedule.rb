class Schedule < ApplicationRecord
  include UtilHelper
  belongs_to :doctor
  belongs_to :hospital
  has_many :bookings

  enum day: %w[monday tuesday wednesday thursday friday saturday sunday]

  def start_hour
    pretty_hour(slot_start)
  end

  def end_hour
    pretty_hour(slot_end + 1)
  end
end
