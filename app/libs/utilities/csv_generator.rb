# frozen_string_literal: true

module Utilities::CSVGenerator
  require 'csv'

  FileNotExist = Class.new(StandardError)

  HEADER = %w[分类名 物品名].freeze
  TMP_DIR = Rails.root.join(Figaro.env.CSV_TMP_DIR)

  def self.generate(options = {})
    timestamp = Time.current.strftime('%Y%m%d%H%M%S%L%N')
    dest = TMP_DIR.join(timestamp)
    FileUtils.mkdir_p(dest) unless File.directory?(dest)

    CSV.open(File.join(dest, 'products.csv'), 'wb') do |csv|
      csv << HEADER

      yield csv
    end

    File.join(Figaro.env.CSV_TMP_DIR, timestamp, 'products.csv')
  end
end
