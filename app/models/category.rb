# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  include SoftDeletable
  has_many :products

  validates :name, presence: true, uniqueness: { conditions: -> { where(deleted_at: nil) } }
end
