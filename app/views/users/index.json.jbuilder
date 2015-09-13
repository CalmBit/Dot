json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :passhash, :bio, :passsalt, :birthday
  json.url user_url(user, format: :json)
end
