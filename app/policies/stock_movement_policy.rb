class StockMovementPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.admin? || user.manager?
  end

  class Scope < Scope
    def resolve
      scope.includes(:warehouse, :product, :user).order(created_at: :desc)
    end
  end
end
