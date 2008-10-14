User.seed(:first_name) do |t|
  t.first_name = "Test"
  t.last_name = "Pledge"
  t.email = "test@example.com"
  t.password = "password"
  t.password_confirmation = "password"
end
