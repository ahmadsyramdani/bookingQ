json.code 200
json.data do
  json.call @doctor,
            :id,
            :specialist_name,
            :name,
            :phone_number

  json.schedules do
    json.array! @doctor.schedules do |schedule|
      json.id schedule.id
      json.hospital do
        json.call schedule.hospital,
                  :id,
                  :name,
                  :category,
                  :address
      end
      json.day schedule.day.titleize
      json.from schedule.start_hour
      json.to schedule.end_hour
    end
  end
end
json.message 'ok'
