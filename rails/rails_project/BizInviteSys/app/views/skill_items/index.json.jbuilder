json.array!(@skill_items) do |skill_item|
  json.extract! skill_item, 
  json.url skill_item_url(skill_item, format: :json)
end
