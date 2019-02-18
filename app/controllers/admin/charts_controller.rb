# frozen_string_literal: true

class Admin::ChartsController < Admin::BaseController
  before_action :load_breadcrumb
  before_action :load_chart, only: %i[edit update destroy]

  def index
    q = Chart.ransack(name_cont: params[:q])
    @charts = q.result.order(created_at: :asc).page(params[:page])
  end

  def new
    @chart = Chart.new
  end

  def create
    @chart = Chart.new(chart_params)
    if @chart.save
      render_turbolinks_reload
    else
      render
    end
  end

  def edit
  end

  def update
    if @chart.update(chart_params)
      render_turbolinks_reload
    else
      render
    end
  end

  def destroy
    @chart.destroy

    render_turbolinks_reload
  end

  private

  def load_chart
    @chart = Chart.find(params[:id])
  end

  def chart_params
    params.require(:chart).permit(:name)
  end

  def load_breadcrumb
    add_breadcrumb '数据总览', admin_dashboards_path
    add_breadcrumb '图表管理', admin_charts_path
  end
end
