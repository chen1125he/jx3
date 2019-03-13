# frozen_string_literal: true

module Prices
  extend ActiveSupport::Concern

  private

  def prices_merge(prices_hash1 = {}, prices_hash2 = {})
    prices_hash2.each do |key, value|
      if prices_hash1[key]
        prices_hash1[key] += value
      else
        prices_hash1[key] = value
      end
    end

    prices_hash1
  end

  def prices_multiply(prices = {}, multiple = 1)
    prices.each { |key, value| prices[key] = value * multiple }
  end

  def prices_devide(prices = {}, devide = 1)
    prices.each { |key, value| prices[key] = value.to_f / devide }
  end
end
