# frozen_string_literal: true

# == Schema Information
#
# Table name: services
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  area_id    :bigint(8)
#
# Indexes
#
#  index_services_on_area_id  (area_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#

class Service < ApplicationRecord
  belongs_to :area
end
