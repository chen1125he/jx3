# frozen_string_literal: true

class Admin::GenerateHistoryPriceCsvWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false

  HEADER = %w[分类名 物品名 价格值(金) 售卖者 记录时间].freeze

  def perform(options = {})
    products = Admin::QueryProductsService.new(options).call

    total(products.count)

    filepath = Utilities::CSVGenerator.generate(filename: 'products.csv') do |csv|
      csv << HEADER

      products.includes(:category, :current_price).each_with_index do |product, index|
        at(index + 1)

        csv << [product.category.name, product.name, product.current_price&.amount, product.current_price&.seller_name, Date.today]
      end
    end

    store payload: { filepath: filepath }.to_json
  end
end
