json.array!(@personal_details) do |personal_detail|
  json.extract! personal_detail, 
  json.url personal_detail_url(personal_detail, format: :json)
end
