json.code 200
json.data do
  json.call @doctor,
            :id,
            :specialist_name,
            :name,
            :phone_number

  json.schedule do
    json.id @schedule.id
    json.hospital do
      json.call @schedule.hospital,
                :id,
                :name,
                :category,
                :address
    end
    json.day @schedule.day.titleize
    json.from @schedule.start_hour
    json.to @schedule.end_hour
  end

  json.bookings do
    json.array! @bookings do |date, list|
      json.date date
      json.list do
        json.array! list do |booking|
          json.id booking.id
          json.patient do
            json.id booking.user.id
            json.email booking.user.email
            json.name booking.user.name
            json.phone_number booking.user.phone_number
          end
          json.appointment_at booking.appointment_at
          json.line_number booking.line_number
          json.estimated_attend_at booking.estimated_attend_at
        end
      end
    end
  end

  json.limit @bookings.limit_value
  json.current_page @bookings.current_page
  json.total_pages @bookings.total_pages
  json.total_count @bookings.total_count
end
json.message 'ok'
