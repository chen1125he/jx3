class Admin::ToppingProductsController < Admin::BaseController
  before_action :load_product, only: [:update]

  def update
    @product.touch
    render_turbolinks_reload
  end

  private

  def load_product
    @product = Product.find(params[:id])
  end
end
