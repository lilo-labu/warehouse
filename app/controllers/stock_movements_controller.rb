class StockMovementsController < ApplicationController
  before_action :load_dependencies, only: [:new, :create]

  def index
    authorize StockMovement
    @pagy, @stock_movements = pagy(policy_scope(StockMovement), limit: 15)
  end

  def new
    @stock_movement = StockMovement.new
    authorize @stock_movement
  end

  def create
    @stock_movement = StockMovement.new(stock_movement_params)
    @stock_movement.user = current_user
    authorize @stock_movement

    if @stock_movement.save
      redirect_to stock_movements_path, notice: "Операция проведена."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def stock_movement_params
    params.require(:stock_movement).permit(:warehouse_id, :product_id, :movement_type, :quantity, :comment)
  end

  def load_dependencies
    @warehouses = Warehouse.order(:name)
    @products = Product.order(:name)
  end
end
