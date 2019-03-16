class Admin::BulkEditProductTagsController < Admin::BaseController
  def edit
  end

  def update
    @products = Admin::QueryProductsService.new(params).call
    @tag_ids = params[:tag_ids].map(&:to_i)

    case params[:type]
    when 'add'
      Admin::BulkEditProductTagsService.new(@products, @tag_ids, :add).call
    when 'remove'
      Admin::BulkEditProductTagsService.new(@products, @tag_ids, :remove).call
    else
      flash[:error] = '参数错误，请刷新重试'
    end

    render_turbolinks_reload
  end
end
