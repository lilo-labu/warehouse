class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  def index
    authorize Warehouse
    @pagy, @warehouses = pagy(policy_scope(Warehouse).order(created_at: :desc), limit: 10)
  end

  def show
    authorize @warehouse
    @inventories = @warehouse.inventories.includes(:product).joins(:product).order("products.name ASC")
  end

  def new
    @warehouse = Warehouse.new
    authorize @warehouse
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    authorize @warehouse

    if @warehouse.save
      redirect_to warehouse_path(@warehouse), notice: "Склад создан."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @warehouse
  end

  def update
    authorize @warehouse

    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse), notice: "Склад обновлён."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @warehouse
    @warehouse.destroy
    redirect_to warehouses_path, notice: "Склад удалён."
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :location)
  end
end
