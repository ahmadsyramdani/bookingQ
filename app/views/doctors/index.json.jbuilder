json.code 200
json.data @doctors,
          :id,
          :specialist_name,
          :name,
          :phone_number

json.limit @doctors.limit_value
json.current_page @doctors.current_page
json.total_pages @doctors.total_pages
json.total_count @doctors.total_count
json.message 'ok'
