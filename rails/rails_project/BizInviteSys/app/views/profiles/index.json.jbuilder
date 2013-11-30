json.array!(@profiles) do |profile|
  json.extract! profile, :category, :stat, :score
  json.url profile_url(profile, format: :json)
end
