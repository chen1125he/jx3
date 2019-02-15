# frozen_string_literal: true

class Admin::BulkImportProductsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false

  def perform(file_path)
    @errors = []
    begin
      csv = Utilities::CSVReader.read(file_path)
      total(csv.count)
      csv.each_with_index do |row, index|
        at(index + 1)
        create_or_update_product(row, index)
      end
    rescue Utilities::CSVReader::FileNotExist => ex
      @errors << { message: ex.message }
    end

    store payload: { errors: @errors }.to_json

    @errors
  end

  private

  # row [category_name, name, avg_amount, game_id]
  def create_or_update_product(row, index)
    category = Category.find_by(name: row[0])
    product = Product.find_or_initialize_by(category: category, name: row[1])

    product.avg_amount = row[2]

    unless product.save
      product.errors.messages.each do |key, message|
        @errors << {
          line: index + 1,
          message: message.join(','),
          attribute: format('%<attribute_name>s(%<attribute_value>s)', attribute_name: Product.human_attribute_name(key), attribute_value: row[1])
        }
      end
    end

    nil
  end
end
