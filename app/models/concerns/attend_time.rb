module AttendTime
  def estimated_attend(schedule, line_number)
    from = Time.current.beginning_of_day + schedule.slot_start.hour
    to = Time.current.beginning_of_day + (schedule.slot_end + 1).hour
    minutes_per_patient = (to.to_i - from.to_i) / 60 / 10
    attend_at = from + ((line_number - 1) * minutes_per_patient).minutes
    attend_at.strftime('%H:%M')
  end
end
