# frozen_string_literal: true

class Admin::DashboardsController < Admin::BaseController
  before_action :load_breadcrumb
  def index; end

  private

  def load_breadcrumb
    add_breadcrumb '数据总览', admin_dashboards_path
  end
end
