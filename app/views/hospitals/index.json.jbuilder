json.code 200
json.data @hospitals,
          :id,
          :name,
          :category,
          :address

json.limit @hospitals.limit_value
json.current_page @hospitals.current_page
json.total_pages @hospitals.total_pages
json.total_count @hospitals.total_count
json.message 'ok'
