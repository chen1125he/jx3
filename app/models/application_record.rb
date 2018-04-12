class ApplicationRecord < ActiveRecord::Base
  require 'csv'
  self.abstract_class = true
  acts_as_paranoid column: :deleted, sentinel_value: false
end
