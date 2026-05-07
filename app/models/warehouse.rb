class Warehouse < ApplicationRecord
  has_many :inventories, dependent: :destroy
  has_many :products, through: :inventories
  has_many :stock_movements, dependent: :restrict_with_error

  validates :name, :location, presence: true
end
