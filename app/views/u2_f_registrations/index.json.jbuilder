json.array!(@u2_f_registrations) do |u2_f_registration|
  json.extract! u2_f_registration, :id
  json.url u2_f_registration_url(u2_f_registration, format: :json)
end
