class ApplicationRecord < ActiveRecord::Base
  require 'csv'
  self.abstract_class = true
  acts_as_paranoid column: :deleted, sentinel_value: false

  CSV_FIELDS = {}

  # 将csv的row解析成param
  def self.get_csv_params(row = [], csv_fields={})
  	csv_fields = csv_fields.present? ? csv_fields.merge({}) : self::CSV_FIELDS.merge({})
  	csv_fields.each do |key, value|
  		if value.is_a? Fixnum
  			csv_fields[key] = row[value]
  		elsif value.is_a? Hash
  			csv_fields[key] = get_csv_params(row, value)
  		end
  	end
  	csv_fields
  end
end
