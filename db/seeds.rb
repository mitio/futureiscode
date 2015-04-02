unless AdminUser.any?
  email    = 'admin@example.com'
  password = 'password'
  AdminUser.create!(email: email, password: password, password_confirmation: password)
  puts "Created an admin user with email: #{email} and password: #{password}"
end
