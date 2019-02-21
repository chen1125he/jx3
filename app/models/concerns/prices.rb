module Prices
  extend ActiveSupport::Concern

  private

  def prices_merge(prices_hash1 = {}, prices_hash2 = {})
    prices_hash2.each do |key, value|
      prices_hash1[key] = value unless prices_hash1[key]
      prices_hash1[key] += value if prices_hash1[key]
    end

    prices_hash1
  end
end
