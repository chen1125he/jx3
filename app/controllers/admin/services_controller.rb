# frozen_string_literal: true

class Admin::ServicesController < Admin::BaseController
  before_action :load_service, only: [:edit, :update, :destroy]

  def index
    q = Service.ransack({name_cont: params[:q], area_name_cont: params[:q]}.merge(m: 'or'))
    @services = q.result.order(created_at: :asc).page(params[:page])
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      render_turbolinks_reload
    else
      render
    end
  end

  def edit
  end

  def update
    if @service.update(service_params)
      render_turbolinks_reload
    else
      render
    end
  end

  def destroy
    @service.soft_delete!

    render_turbolinks_reload
  end

  private

  def load_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :area_id)
  end
end
