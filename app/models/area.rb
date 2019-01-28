# frozen_string_literal: true

# == Schema Information
#
# Table name: areas
#
#  id         :bigint(8)        not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Area < ApplicationRecord
  include SoftDeletable
  has_many :services
end
