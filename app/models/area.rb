# == Schema Information
#
# Table name: areas
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Area < ApplicationRecord
  has_many :services
end
