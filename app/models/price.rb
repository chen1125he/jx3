# frozen_string_literal: true

# == Schema Information
#
# Table name: prices
#
#  id                         :bigint(8)        not null, primary key
#  amount                     :decimal(12, 4)   default(0.0)
#  currency_type(价格的货币类型)     :string
#  price_type(是否是固定的，否则有价格历史) :string
#  record_date(此价格的时间)        :date
#  seller_name(售卖者)           :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  owner_id                   :bigint(8)
#  service_id                 :bigint(8)
#
# Indexes
#
#  index_prices_on_owner_id    (owner_id)
#  index_prices_on_service_id  (service_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => products.id)
#

class Price < ApplicationRecord
  extend Enumerize
  belongs_to :owner, class_name: 'Product', foreign_key: :owner_id
  belongs_to :service, optional: true

  enumerize :price_type, in: %w[history_price system_price], default: :history_price
  enumerize :currency_type, in: %w[gold jingli xiayi jianggong jianben weiwang duihuanpai], default: :gold

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :currency_type, presence: true
  validates :record_date, uniqueness: { scope: %i[record_date owner_id service_id], message: :price_taken }, if: proc { |p| p.price_type.history_price? }
  validates :currency_type, uniqueness: { scope: %i[currency_type owner_id], message: :price_currency_type_taken }, if: proc { |p| p.price_type.system_price? }
end
