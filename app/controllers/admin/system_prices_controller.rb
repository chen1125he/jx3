# frozen_string_literal: true

class Admin::SystemPricesController < Admin::BaseController
  before_action :load_product, only: %i[new create edit update destroy]
  before_action :load_system_price, only: %i[edit update destroy]

  def new
    @system_price = @product.system_prices.new
  end

  def create
    @system_price = @product.system_prices.new(system_price_params)
    if @system_price.save
      render_turbolinks_reload
    else
      render
    end
  end

  def edit
  end

  def update
    if @system_price.update(system_price_params)
      render_turbolinks_reload
    else
      render
    end
  end

  def destroy
    @system_price.destroy

    render_turbolinks_reload
  end

  private

  def load_product
    @product = Product.find(params[:product_id])
  end

  def load_system_price
    @system_price = @product.system_prices.find(params[:id])
  end

  def system_price_params
    params.require(:price).permit(:currency_type, :seller_name, :amount)
  end
end
