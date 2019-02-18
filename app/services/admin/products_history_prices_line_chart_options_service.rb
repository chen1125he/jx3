# frozen_string_literal: true

class Admin::ProductsHistoryPricesLineChartOptionsService
  def initialize(products = [], options = {})
    days = options.delete(:days) || 5

    @recent_days = 1.upto(days).map { |i| Date.today - (days - i).days }

    @title = options.delete(:title)

    @products = products

    @options = Echarts.options
  end

  def call
    set_title_text!

    set_legend_data!

    set_x_axis_data!

    set_series!

    @options
  end

  private

  def set_title_text!
    @options[:title][:text] = @title
  end

  def set_legend_data!
    @options[:legend][:data] = @products.pluck(:name)
  end

  def set_x_axis_data!
    @options[:xAxis][:data] = @recent_days.map { |d| d.strftime('%Y/%m/%d') }
  end

  def set_series!
    @products.each do |product|
      history_prices = product.history_prices.order(record_date: :desc).limit(5).to_a

      @options[:series] << {
        name: product.name,
        type: :line,
        data: @recent_days.map do |date|
          history_prices.find { |price| price.record_date == date }&.amount.to_f || 0
        end
      }
    end
  end
end
