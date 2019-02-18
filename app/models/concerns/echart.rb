# frozen_string_literal: true

module EchartData
  extend ActiveSupport::Concern

  def recent_prices_in_days(day = 5)
    dates = 1.upto(day).map { |i| Date.today - (day - i).days }
    hps = history_prices.order(record_date: :asc).limit(5).to_a

    dates.map do |date|
      hps.find { |p| p.record_date == date }&.amount || 0
    end
  end
end
