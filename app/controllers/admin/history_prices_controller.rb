# frozen_string_literal: true

class Admin::HistoryPricesController < Admin::BaseController
  before_action :load_product
  before_action :load_breadcrumb
  before_action :load_history_price, only: %i[edit update destroy]

  def index
    add_breadcrumb @product.name, edit_admin_product_path(@product)
    add_breadcrumb '历史价格'

    @history_prices = @product.history_prices.order(record_date: :desc).page(params[:page])
  end

  def new
    @history_price = @product.history_prices.new
  end

  def create
    @history_price = @product.history_prices.new(history_price_params)
    @history_price.service = current_service
    if @history_price.save
      render_turbolinks_reload
    else
      render
    end
  end

  def edit
  end

  def update
    @history_price.service = current_service
    if @history_price.update(history_price_params)
      render_turbolinks_reload
    else
      render
    end
  end

  def destroy
    @history_price.destroy

    render_turbolinks_reload
  end

  private

  def load_product
    @product = Product.find(params[:product_id])
  end

  def load_history_price
    @history_price = @product.history_prices.find(params[:id])
  end

  def history_price_params
    params.require(:price).permit(:seller_name, :amount, :record_date)
  end

  def load_breadcrumb
    add_breadcrumb '物品管理', admin_products_path
  end
end
