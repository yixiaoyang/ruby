json.array!(@comments) do |comment|
  json.extract! comment, :score, :vluation, :profile_id, :user_id
  json.url comment_url(comment, format: :json)
end
