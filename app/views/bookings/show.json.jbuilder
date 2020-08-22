json.code 200
json.data do
  json.id @booking.id
  json.schedule do
    json.day @booking.schedule.day
    json.from @booking.schedule.start_hour
    json.to @booking.schedule.end_hour
  end
  json.doctor do
    json.name @booking.schedule.doctor.name
    json.phone_number @booking.schedule.doctor.phone_number
    json.specialist @booking.schedule.doctor.specialist_name
  end
  json.hospital do
    json.name @booking.schedule.hospital.name
    json.category @booking.schedule.hospital.category
    json.address @booking.schedule.hospital.address
  end
  json.appointment_at @booking.appointment_at
  json.line_number @booking.line_number
  json.estimated_attend_at @booking.estimated_attend_at
end
json.message 'ok'
