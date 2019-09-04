class Admin::ProductDetailTreeChartOptionsService
  def initialize(product = nil)
    @product = product
    @data = {
      name: @product.name,
      children: []
    }
    @options = Echarts.tree_options
  end

  def call
    return @options unless @product.present?

    set_current_price!

    set_requirements!

    set_level_one_cost!

    set_level_two_cost!

    @options
  end

  private

  def set_current_price!
    @data[:children] << {
      name: format('当前价格: %<current_price>s', current_price: @product.current_price.amount),
      value: @product.current_price.amount
    }
  end

  def set_requirements!
    @data[:children] << {
      name: '所需材料',
      children: @product.tree_requirements(level: 2)
    }
  end

  def set_level_one_cost!
    @data[:children] << {
      name: '购买高级材料花费',
      children: @product.tree_cost
    }
  end

  def set_level_two_cost!
    @data[:children] << {
      name: '自制高级材料花费',
      children: @product.tree_cost(2)
    }
  end
end
