# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Seeds for Stocks
Stock.create([
  { name: 'Apple', ticker: 'AAPL', price: 150.0 },
  { name: 'Google', ticker: 'GOOGL', price: 2800.0 },
  { name: 'Amazon', ticker: 'AMZN', price: 3400.0 },
  { name: 'Microsoft', ticker: 'MSFT', price: 290.0 }
])

# Create an admin user for testing if it doesn't already exist
admin_email = 'admin@email.com'
unless User.exists?(email: admin_email)
  User.create(email: admin_email, password: 'admin123', user_type: 'admin', creation_status: 'approved')
end
