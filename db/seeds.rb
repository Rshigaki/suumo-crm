# Create default company
company = Company.create!(name: "Test Construction Co.")

# Create admin user
User.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  name: "Admin User",
  role: :admin,
  company: company
)

# Create staff user
User.create!(
  email: "staff@example.com",
  password: "password",
  password_confirmation: "password",
  name: "Sales Staff",
  role: :staff,
  company: company
)

puts "Seeding completed successfully!"
