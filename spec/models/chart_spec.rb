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

require 'rails_helper'

RSpec.describe Chart, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end