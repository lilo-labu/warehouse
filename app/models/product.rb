class Product < ApplicationRecord
  belongs_to :category

  has_many :inventories, dependent: :destroy
  has_many :warehouses, through: :inventories
  has_many :stock_movements, dependent: :restrict_with_error

  validates :name, :sku, presence: true
  validates :sku, uniqueness: true
end
