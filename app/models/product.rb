# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                          :bigint(8)        not null, primary key
#  avg_amount(平均获得数量(如生活技能物品)) :float            default(1.0)
#  deleted_at                  :datetime
#  name                        :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  category_id                 :bigint(8)
#  game_id                     :string
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#

class Product < ApplicationRecord
  include SoftDeletable
  include Prices

  belongs_to :category
  has_many :history_prices, -> { where(price_type: :history_price) }, dependent: :destroy, class_name: 'Price', foreign_key: :owner_id
  has_one :current_price, -> { where(price_type: :history_price).order(id: :desc) }, class_name: 'Price', foreign_key: :owner_id
  has_many :system_prices, -> { where(price_type: :system_price) }, dependent: :destroy, class_name: 'Price', foreign_key: :owner_id
  has_many :produce_prices, -> { where(price_type: :produce_price) }, dependent: :destroy, class_name: 'Price', foreign_key: :owner_id
  has_many :requirements, dependent: :destroy, foreign_key: :owner_id
  has_many :materials, through: :requirements
  has_many :chart_items, as: :item

  validates :name, presence: true, uniqueness: { scope: %i[category_id], conditions: -> { where(deleted_at: nil) }, message: :product_taken }
  validates :avg_amount, presence: true, numericality: { allow_nil: true, greater_than_or_equal_to: 0 }

  def produce_cost(requirements_produce = false)
    prices = {}
    produce_prices.map { |price| prices = prices_merge(prices, { price.currency_type_text => price.amount }) }
    if requirements_produce
      materials.each { |m| prices = prices_merge(prices, m.produce_cost) }
    else
      materials.map(&:current_price).compact.map { |price| prices = prices_merge(prices, { price.currency_type_text => price.amount }) }
    end

    prices
  end
end
