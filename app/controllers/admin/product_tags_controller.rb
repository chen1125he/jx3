class Admin::ProductTagsController < Admin::BaseController
  before_action :load_product, only: [:edit, :update]

  def edit
  end

  def update
    @product.tags = Tag.where(id: params[:tag_ids])

    render_turbolinks_reload
  end

  private

  def load_product
    @product = Product.find(params[:product_id])
  end
end
