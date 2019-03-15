# frozen_string_literal: true

class Admin::MaterialsController < Admin::BaseController
  def index
    q = Product.ransack(name_cont: params[:q])
    @materials = q.result.order(created_at: :asc).page(params[:page])

    render json: { items: @materials.map { |m| { name: m.name, id: m.id } }, more: @materials.current_page < @materials.total_pages }
  end
end
