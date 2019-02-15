# frozen_string_literal: true

module Utilities::CSVGenerator
  require 'csv'

  FileNotExist = Class.new(StandardError)
  TMP_DIR = Rails.root.join(Figaro.env.CSV_TMP_DIR)

  def self.generate(options = {})
    timestamp = Time.current.strftime('%Y%m%d%H%M%S%L%N')
    dest = TMP_DIR.join(timestamp)
    filename = options[:filename].presence || format('file_%<timestamp>s.csv', timestamp: timestamp)
    FileUtils.mkdir_p(dest) unless File.directory?(dest)

    CSV.open(File.join(dest, filename), 'wb') do |csv|
      yield csv
    end

    File.join(Figaro.env.CSV_TMP_DIR, timestamp, filename)
  end
end
