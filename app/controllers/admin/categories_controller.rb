# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.order(created_at: :asc).page(params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render_turbolinks_reload
    else
      render
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      render_turbolinks_reload
    else
      render
    end
  end

  def destroy
    @category.soft_delete!
    
    render_turbolinks_reload
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
