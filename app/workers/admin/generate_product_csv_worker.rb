# frozen_string_literal: true

class Admin::GenerateProductCsvWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false

  HEADER = %w[分类名 物品名 平均生成数].freeze

  def perform(options = {})
    total(Product.all.count)

    filepath = Utilities::CSVGenerator.generate(filename: 'products.csv') do |csv|
                 csv << HEADER

                 Product.all.includes(:category).each_with_index do |product, index|
                   at(index + 1)

                   csv << [product.category.name, product.name, product.avg_amount]
                 end
               end

    store payload: { filepath: filepath }.to_json
  end
end
