# == Schema Information
#
# Table name: products
#
#  id                          :bigint(8)        not null, primary key
#  avg_amount(平均获得数量(如生活技能物品)) :float            default(1.0)
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

require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
