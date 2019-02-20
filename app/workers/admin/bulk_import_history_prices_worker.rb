# frozen_string_literal: true

class Admin::BulkImportHistoryPricesWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false

  def perform(file_path, service_id)
    @errors = []
    begin
      @service = Service.find(service_id)

      csv = Utilities::CSVReader.read(file_path)
      total(csv.count)
      csv.each_with_index do |row, index|
        at(index + 1)
        create_or_update_history_price(row, index)
      end
    rescue Utilities::CSVReader::FileNotExist => ex
      @errors << { message: ex.message }
    rescue => ex
      @errors << { message: ex.message }
    end

    store payload: { errors: @errors }.to_json

    @errors
  end

  private

  # row [category_name, product_name, amount, seller_name, record_date]
  def create_or_update_history_price(row, index)
    category = Category.find_by(name: row[0])
    product = category.products.find_by(name: row[1])

    price = product.history_prices.find_or_initialize_by(record_date: row[4], service: @service)

    price.amount = row[2]
    price.seller_name = row[3]

    unless price.save
      price.errors.messages.each do |key, message|
        @errors << {
          line: index + 1,
          message: message.join(','),
          attribute: format('%<category_name>s-%<product_name>s(%<attribute_name>s)', category_name: row[0], product_name: row[1], attribute_name: Price.human_attribute_name(key))
        }
      end
    end

    nil
  end
end
