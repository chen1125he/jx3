# frozen_string_literal: true

class Admin::AreasController < Admin::BaseController
  before_action :load_breadcrumb
  before_action :load_area, only: [:edit, :update, :destroy]

  def index
    q = Area.ransack(name_cont: params[:q])
    @areas = q.result.order(created_at: :asc).page(params[:page])
  end

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      render_turbolinks_reload
    else
      render
    end
  end

  def edit
  end

  def update
    if @area.update(area_params)
      render_turbolinks_reload
    else
      render
    end
  end

  def destroy
    @area.soft_delete!

    render_turbolinks_reload
  end

  private

  def load_area
    @area = Area.find(params[:id])
  end

  def area_params
    params.require(:area).permit(:name)
  end

  def load_breadcrumb
    add_breadcrumb '大区管理', admin_areas_path
  end
end
