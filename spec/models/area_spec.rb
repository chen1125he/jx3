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

require 'rails_helper'

RSpec.describe Area, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
