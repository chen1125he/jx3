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
#  fk_rails_...  (service_id => services.id)
#

require 'rails_helper'

RSpec.describe Price, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
