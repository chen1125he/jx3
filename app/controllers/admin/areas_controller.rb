# frozen_string_literal: true

class Admin::AreasController < Admin::BaseController
  before_action :load_breadcrumb

  def index
    q = Area.ransack(name_cont: params[:q])
    @areas = q.result.order(created_at: :asc).page(params[:page])
  end

  private

  def load_breadcrumb
    add_breadcrumb '大区管理', admin_areas_path
  end
end
