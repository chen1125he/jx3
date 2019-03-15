# frozen_string_literal: true

class Admin::TagsController < Admin::BaseController
  before_action :load_tag, only: [:edit, :update, :destroy]
  before_action :load_breadcrumb, only: [:index]

  def index
    q = Tag.ransack(name_cont: params[:q])
    @tags = q.result.order(created_at: :asc).page(params[:page])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render_turbolinks_reload
    else
      render
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      render_turbolinks_reload
    else
      render
    end
  end

  def destroy
    @tag.destroy

    render_turbolinks_reload
  end

  private

  def load_breadcrumb
    add_breadcrumb '标签管理', admin_tags_path
  end

  def load_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
