# frozen_string_literal: true

# == Schema Information
#
# Table name: requirements
#
#  id          :bigint(8)        not null, primary key
#  amount      :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  material_id :bigint(8)
#  owner_id    :bigint(8)
#
# Indexes
#
#  index_requirements_on_material_id  (material_id)
#  index_requirements_on_owner_id     (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (material_id => products.id)
#  fk_rails_...  (owner_id => products.id)
#

class Requirement < ApplicationRecord
  belongs_to :owner, class_name: 'Owner'
  belongs_to :material, class_name: 'Product'
end
