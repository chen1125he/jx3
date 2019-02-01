# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.page(params[:page])
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

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
