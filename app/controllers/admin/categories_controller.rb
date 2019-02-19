# frozen_string_literal: true

class Admin::CategoriesController < Admin::BaseController
  before_action :load_breadcrumb

  def index
    q = Category.ransack(name_cont: params[:q])
    @categories = q.result.order(created_at: :asc).page(params[:page])
  end

  private

  def load_breadcrumb
    add_breadcrumb '分类管理', admin_categories_path
  end
end
