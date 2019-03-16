class Admin::QueryProductsService
  def initialize(options = {})
    @options = options
  end

  def call
    Product.ransack({ category_name_cont: @options['q'], name_cont: @options['q'], tags_name_cont: @options['q'] }.merge(m: 'or')).result(distinct: true).order(updated_at: :desc)
  end
end
