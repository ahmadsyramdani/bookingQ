json.code 200
json.data do
  json.call @hospital,
            :id,
            :name,
            :category,
            :address
end
json.message 'ok'
