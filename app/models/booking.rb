class Booking < ApplicationRecord
  include AttendTime
  belongs_to :user
  belongs_to :schedule
  paginates_per 10

  before_save :get_line_number

  validates :user_id, uniqueness: { scope: %i[schedule_id appointment_at],
                                    message: 'already book the schedule' }
  validates :appointment_at, presence: true
  validate :working_day, :appointment, :limit_patient, :half_hour_before_start

  scope :upcoming, -> { where("appointment_at >= '#{Time.current.to_date}'") }

  def working_day
    schedule = Schedule.find_by(id: schedule_id)
    return errors.add(:schedule, 'not found') unless schedule
    return errors.add(:appointment_at, 'is required') unless appointment_at
    return errors.add(:schedule_id, 'day not found') if appointment_at.present? && (appointment_at.to_date.strftime('%A').downcase != schedule.day.downcase)
  end

  def appointment
    return errors.add(:appointment_at, 'is required') unless appointment_at
    return errors.add(:appointment_at, 'please choose current or future date') if appointment_at.present? && (appointment_at.to_date < Date.today)
  end

  def limit_patient
    return errors.add(:appointment_at, 'is required') unless appointment_at

    appointment = appointment_at.to_date
    booking = Booking.where(schedule_id: schedule_id, appointment_at: appointment)
    return errors.add(:appointment_at, 'this schedule is fully booked, , try another schedule') if booking.count == 10
  end

  def half_hour_before_start
    return unless appointment_at.to_date == Time.current.to_date

    schedule = Schedule.find_by(id: schedule_id)
    return errors.add(:schedule, 'not found') unless schedule

    start_time = (Time.current.beginning_of_day + schedule.slot_start.hour).to_i
    register_at = Time.current.to_i
    time_remaining = (start_time - register_at) / 60
    return errors.add(:appointment_at, 'registration is closed, try another schedule') unless time_remaining > 30
  end

  def get_line_number
    appointment = appointment_at.to_date
    booking = Booking.where(schedule_id: schedule_id, appointment_at: appointment)
    self.line_number = booking.count + 1 if line_number.blank?
  end

  def estimated_attend_at
    line_number.blank? ? 'come early 30 minute before start' : estimated_attend(schedule, line_number)
  end
end
