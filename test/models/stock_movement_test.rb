require "test_helper"

class StockMovementTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "manager@example.com", password: "password123", role: :manager)
    @warehouse = Warehouse.create!(name: "Main Warehouse", location: "Moscow")
    @category = Category.create!(name: "Electronics")
    @product = Product.create!(name: "Scanner", sku: "SCN-001", category: @category)
  end

  test "inbound increases inventory quantity" do
    StockMovement.create!(
      user: @user,
      warehouse: @warehouse,
      product: @product,
      movement_type: "inbound",
      quantity: 10
    )

    inventory = Inventory.find_by!(warehouse: @warehouse, product: @product)
    assert_equal 10, inventory.quantity
  end

  test "outbound validates available stock" do
    StockMovement.create!(
      user: @user,
      warehouse: @warehouse,
      product: @product,
      movement_type: "inbound",
      quantity: 5
    )

    movement = StockMovement.new(
      user: @user,
      warehouse: @warehouse,
      product: @product,
      movement_type: "outbound",
      quantity: 8
    )

    assert_not movement.valid?
    assert_includes movement.errors[:quantity].first, "cannot exceed available stock"
  end
end
