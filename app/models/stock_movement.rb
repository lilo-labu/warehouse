class StockMovement < ApplicationRecord
  MOVEMENT_TYPES = %w[inbound outbound].freeze

  belongs_to :warehouse
  belongs_to :product
  belongs_to :user

  validates :movement_type, inclusion: { in: MOVEMENT_TYPES }
  validates :quantity, numericality: { greater_than: 0 }

  validate :sufficient_stock_for_outbound, if: -> { movement_type == "outbound" }

  after_create :apply_to_inventory!

  private

  def sufficient_stock_for_outbound
    inventory = Inventory.find_by(warehouse:, product:)
    current_quantity = inventory&.quantity.to_i
    return unless quantity.to_i > current_quantity

    errors.add(:quantity, "cannot exceed available stock (#{current_quantity})")
  end

  def apply_to_inventory!
    inventory = Inventory.find_or_create_by!(warehouse:, product:) do |record|
      record.quantity = 0
    end

    new_quantity = movement_type == "inbound" ? inventory.quantity + quantity : inventory.quantity - quantity
    inventory.update!(quantity: new_quantity)
  end
end
