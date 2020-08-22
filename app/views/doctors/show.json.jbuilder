json.code 200
json.data do
  json.call @doctor,
            :id,
            :specialist_name,
            :name,
            :phone_number
end
json.message 'ok'
