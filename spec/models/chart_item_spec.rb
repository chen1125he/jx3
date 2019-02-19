# frozen_string_literal: true

# == Schema Information
#
# Table name: chart_items
#
#  id         :bigint(8)        not null, primary key
#  item_type  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chart_id   :bigint(8)
#  item_id    :bigint(8)
#
# Indexes
#
#  index_chart_items_on_chart_id               (chart_id)
#  index_chart_items_on_item_type_and_item_id  (item_type,item_id)
#
# Foreign Keys
#
#  fk_rails_...  (chart_id => charts.id)
#

require 'rails_helper'

RSpec.describe ChartItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
