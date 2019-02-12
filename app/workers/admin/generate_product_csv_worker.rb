# frozen_string_literal: true

class Admin::GenerateProductCsvWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false

  def perform(options = {})
    total(Product.all.count)

    filepath = Utilities::CSVGenerator.generate do |csv|
                 Product.all.includes(:category).each_with_index do |product, index|
                   at(index + 1)
                   
                   csv << [product.category.name, product.name]
                 end
               end

    store payload: { filepath: filepath }.to_json
  end
end
