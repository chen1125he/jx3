class Admin::SystemPricesController < Admin::BaseController
  before_action :load_product, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_system_price, only: [:edit, :update, :destroy]

  def new
    @system_price = @product.system_prices.new
  end

  def create
    @system_price = @product.system_prices.new(system_price_params)
    if @system_price.save
      render 'update_system_price_list'
    else
      render
    end
  end

  def edit
  end

  def update
    if @system_price.update(system_price_params)
      render 'update_system_price_list'
    else
      render
    end
  end

  def destroy
    @system_price.destroy

    render 'update_system_price_list'
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
