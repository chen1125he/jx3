class Product < ApplicationRecord

  has_many :prices
  has_and_belongs_to_many :requireds, :join_table => 'product_to_products'

  CSV_IMPORT_DIR = File.join(Rails.root, 'csv_import_dir')



  def price
    prices.order(:id => :desc).first.try(:amount).to_i
  end


  def self.csv_import(file_name = '')
    FileUtils.mkdir_p(CSV_IMPORT_DIR) unless File.exist?(CSV_IMPORT_DIR)
    return 'File Not Exists!' unless file_name.present? && File.exist?(File.join(CSV_IMPORT_DIR, file_name))
    pp 111
    CSV.read(File.join(CSV_IMPORT_DIR, file_name), encoding: 'gb2312') do |row|
      pp row
      row = encoding(row)
      pp row
      # 交易行物品
      product_param = {}
      product_param[:category_id] = row[0]
      product_param[:game_id] = row[1]
      product_param[:name] = row[2]
      # 价格
      price_param = {}
      price_param[:amount] = row[3]
      price_param[:record_time] = row[4]
      price_param[:seller_name] = row[5]

      product = Product.find_or_initialize_by(:name => product_param[:name])
      product.attributes = product_param
      product.prices << Price.new(price_param)
      # product.save
    end
  end

  def self.encoding row = []
    row.collect{|s| s.force_encoding('gb2312').encode('utf-8')}
  end
end
