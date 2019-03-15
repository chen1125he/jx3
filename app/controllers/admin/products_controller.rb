# frozen_string_literal: true

class Admin::ProductsController < Admin::BaseController
  before_action :load_breadcrumb
  before_action :load_product, only: %i[edit update]

  def index
    q = Admin::QueryProductsService.new(params).call
    @products = q.includes(:category, :system_prices, :current_price, :tags).page(params[:page])
  end

  def edit
    add_breadcrumb '编辑物品'
  end

  def update
    add_breadcrumb '编辑物品'
    render :edit
  end

  private

  def load_product
    @product = Product.find(params[:id])
  end

  def load_breadcrumb
    add_breadcrumb '物品管理', admin_products_path
  end
end
