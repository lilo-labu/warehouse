class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :load_categories, only: [:new, :create, :edit, :update]

  def index
    authorize Product
    products_scope = policy_scope(Product).order(created_at: :desc)
    @pagy, @products = pagy(products_scope, limit: 10)
  end

  def show
    authorize @product
    @inventories = @product.inventories.includes(:warehouse).joins(:warehouse).order("warehouses.name ASC")
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      redirect_to product_path(@product), notice: "Товар создан."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @product
  end

  def update
    authorize @product

    if @product.update(product_params)
      redirect_to product_path(@product), notice: "Товар обновлён."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to products_path, notice: "Товар удалён."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :sku, :category_id)
  end

  def load_categories
    @categories = Category.order(:name)
  end
end
