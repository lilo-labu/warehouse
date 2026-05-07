admin = User.find_or_create_by!(email: "admin@warehouse.local") do |user|
  user.password = "password123"
  user.role = :admin
end

manager = User.find_or_create_by!(email: "manager@warehouse.local") do |user|
  user.password = "password123"
  user.role = :manager
end

category = Category.find_or_create_by!(name: "General")
warehouse = Warehouse.find_or_create_by!(name: "Main Warehouse", location: "Moscow")
product = Product.find_or_create_by!(sku: "SKU-001") do |record|
  record.name = "Sample Item"
  record.category = category
end

unless StockMovement.exists?(warehouse:, product:, movement_type: "inbound", quantity: 50)
  StockMovement.create!(
    warehouse: warehouse,
    product: product,
    user: manager,
    movement_type: "inbound",
    quantity: 50,
    comment: "Initial load from seeds"
  )
end

puts "Seed completed. Admin: #{admin.email}, Manager: #{manager.email}, password: password123"
