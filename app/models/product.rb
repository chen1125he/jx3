class Product < ApplicationRecord

  has_many :prices
  has_many :product_to_products
  has_many :requireds, :through => :product_to_products

  CSV_IMPORT_DIR = File.join(Rails.root, 'csv_import_dir')

  # 获取当前价格
  def price
    prices.order(:id => :desc).first.try(:amount).to_f
  end

  # 获取所需要的材料
  # return: [{amount: '', name: '', price: ''}]
  def get_requireds
    product_to_products.includes(:required).collect do |ptp|
      {amount: ptp.amount, name: ptp.required.try(:name), price: ptp.required.try(:price)}
    end
  end

  # 添加材料关联, 更新关联信息
  # param: hash = {amount: '', required: '', required_id: ''}
  def add_or_update_required(hash={})
    return 'no data' unless hash.present?
    amount = hash[:amount].present? ? hash.delete(:amount).to_i : 1
    required = hash.delete(:required)
    required_id = hash.delete(:required_id)

    if required.present? && required.class == Required
      required_id = requirerd.id
    end
    if required_id.present? && self.id.present?
      ptp = ProductToProduct.find_or_initialize_by(product_id: self.id, required_id: required_id)
      ptp.amount = amount
      ptp.save
      return 'added success'
    elsif  required_id.present? && self.id.blank?
      self.product_to_products << ProductToProduct.new(required_id: required_id, amount: amount)
      return 'added to its product_to_products'
    end
  end

  # 导入csv
  def self.csv_import(file_name = '')
    FileUtils.mkdir_p(CSV_IMPORT_DIR) unless File.exist?(CSV_IMPORT_DIR)
    return 'File Not Exists!' unless file_name.present? && File.exist?(File.join(CSV_IMPORT_DIR, file_name))
    CSV.read(File.join(CSV_IMPORT_DIR, file_name), encoding: 'gb2312').each_with_index do |row, index|
      next if index == 0
      # row = encoding(row)
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
      product.save
    end
  end

  # 加编码
  def self.encoding row = []
    row.collect{|s| s.force_encoding('gb2312').encode('utf-8')}
  end
end
