# frozen_string_literal: true

class Admin::ServicesController < Admin::BaseController
  before_action :load_breadcrumb

  def index
    q = Service.ransack({ name_cont: params[:q], area_name_cont: params[:q] }.merge(m: 'or'))
    @services = q.result.order(created_at: :asc).page(params[:page])
  end

  private

  def load_breadcrumb
    add_breadcrumb '服务器管理', admin_services_path
  end
end
