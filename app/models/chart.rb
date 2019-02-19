# frozen_string_literal: true

# == Schema Information
#
# Table name: charts
#
#  id         :bigint(8)        not null, primary key
#  chart_type :string
#  item_type  :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Chart < ApplicationRecord
  extend Enumerize

  enumerize :chart_type, in: %w[line tree bar], default: :line
  enumerize :item_type, in: %w[product], default: :product

  has_many :chart_items, dependent: :destroy
  has_many :product_items, through: :chart_items, source_type: 'Product', source: :item
end
