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
  has_many :history_prices, -> { where(price_type: :history_price) }, dependent: :destroy, class_name: 'Price', foreign_key: :owner_id
  has_many :system_prices, -> { where(price_type: :system_price) }, dependent: :destroy, class_name: 'Price', foreign_key: :owner_id
  has_many :requirements, as: :owner, dependent: :destroy
  has_many :materials, through: :requirements

  validates :name, presence: true
  validates :avg_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
