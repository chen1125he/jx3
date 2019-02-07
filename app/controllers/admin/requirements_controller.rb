# frozen_string_literal: true

class Admin::RequirementsController < Admin::BaseController
  before_action :load_product, only: %i[new create edit update destroy]
  before_action :load_requirement, only: %i[edit update destroy]

  def new
    @requirement = @product.requirements.new
  end

  def create
    @requirement = @product.requirements.new(requirement_params)
    @requirement.owner = @product
    if @requirement.save
      render_turbolinks_reload
    else
      render
    end
  end

  def edit
  end

  def update
    if @requirement.update(requirement_params)
      render_turbolinks_reload
    else
      render
    end
  end

  def destroy
    @requirement.destroy

    render_turbolinks_reload
  end

  private

  def load_product
    @product = Product.find(params[:product_id])
  end

  def load_requirement
    @requirement = @product.requirements.find(params[:id])
  end

  def requirement_params
    params.require(:requirement).permit(:material_id, :amount)
  end
end
