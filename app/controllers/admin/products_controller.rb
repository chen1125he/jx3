# frozen_string_literal: true

class Admin::ProductsController < Admin::BaseController
  before_action :load_product, only: [:edit, :update, :destroy]

  def index
    q = Product.ransack(name_cont: params[:q])
    @products = q.result.order(created_at: :asc).page(params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to edit_admin_product_path(@product)
    else
      render :new
    end
  end

  def edit
  end

  def update
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

  def product_params
    params.require(:product).permit(:name, :category_id, :avg_amount, :game_id)
  end
end
