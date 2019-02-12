# frozen_string_literal: true

module Utilities::CSVReader
  require 'csv'

  FileNotExist = Class.new(StandardError)

  def self.read(csv_path)
    raise FileNotExist, '文件读取失败或为空, 请重新上传' unless File.exist?(csv_path)

    CSV.read(csv_path, headers: true)
    # CSV.foreach(csv_path).with_index do |row, index|
    # yield row, index, total_line
    # end
  end
end
