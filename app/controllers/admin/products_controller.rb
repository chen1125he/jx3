# frozen_string_literal: true

class Admin::ProductsController < Admin::BaseController
  before_action :load_breadcrumb
  before_action :load_product, only: [:edit, :update, :destroy]
  before_action :load_history_prices, only: [:edit, :update]

  def index
    q = Product.ransack({cateogry_name_cont: params[:q], name_cont: params[:q]}.merge(m: :or))
    @products = q.result.includes(:category, :system_prices).order(created_at: :asc).page(params[:page])
  end

  def new
    add_breadcrumb '添加物品'

    @product = Product.new
  end

  def create
    add_breadcrumb '添加物品'

    @product = Product.new(product_params)
    if @product.save
      redirect_to edit_admin_product_path(@product)
    else
      render :new
    end
  end

  def edit
    add_breadcrumb '编辑物品'
  end

  def update
    add_breadcrumb '编辑物品'
    
    if @product.update(product_params)
      redirect_to edit_admin_product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product.soft_delete!

    render_turbolinks_reload
  end

  private

  def load_product
    @product = Product.find(params[:id])
  end

  def load_history_prices
    @history_prices = @product.history_prices.order(record_date: :desc).limit(5)
  end

  def product_params
    params.require(:product).permit(:name, :category_id, :avg_amount, :game_id)
  end

  def load_breadcrumb
    add_breadcrumb '物品管理', admin_products_path
  end
end
