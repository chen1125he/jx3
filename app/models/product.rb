class Product < ApplicationRecord

  CSV_IMPORT_DIR = File.join(Rails.root, 'product_csv_import_dir')
  
  CSV_FIELDS = {
    product_param: {
      category_id: 0, 
      game_id: 1, 
      name: 2,
      compile_flag: 3,
      vigor_cost: 4,
      avg_amount: 5,
      price: 6
      }, 
    price_param: {
      amount: 6, 
      record_time: 7, 
      seller_name: 8
      }
    }

  has_many :prices
  has_many :product_to_products
  has_many :requireds, :through => :product_to_products

  validate :category_present

  # validate
  def category_present
    unless category_id.present?
      errors.add(:category_id, I18n.t(:blank))
      return
    end
    unless Category.where(:id => category_id).first.present?
      errors.add(:category_id, I18n.t(:not_exists))
      return
    end
  end

  # 已经添加了当前价格字段
  # 获取当前价格
  # def price
    # prices.order(:id => :desc).first.try(:amount).to_f
  # end

  # 获取每一个物品所耗费精力
  def vigor_cost_per
    vigor_cost/avg_amount
  end

  # 获取收益
  def get_profit(amount = 0)
    # amount == 0 ? avg_amount
    # get_requireds.each do 
    # price 
  end

  # 获取成本
  # return: {price: '', cost: '', self_requireds: ''}
  # avg_flag, 是否要算平均cost, basic_material, 是否计算物品的组合材料的材料+精力(计算多少级的下级材料 0为否), self_requireds, 值为get_requireds类似，递归用
  def get_cost(basic_material = 0, self_requireds = nil, avg_flag = true)
    self_requireds ||= get_requireds(basic_material)
    costs = {price: self_requireds[:price], cost: 0, vigor_cost: self_requireds[:vigor_cost].to_f}
    self_requireds[:requireds].each do |key, value|
      if value[:requireds].present? && basic_material > 0
        value = get_cost(basic_material-1, value, false)
        costs[:vigor_cost] += value[:vigor_cost].to_f
      end
      costs[:cost] += value[:price].to_f * value[:amount].to_f
    end
    if(avg_flag)
      return {price: costs[:price].to_f, cost: (costs[:cost]/avg_amount).to_f, vigor_cost_per: (costs[:vigor_cost]/avg_amount).to_f}
    else
      return costs
    end
  end

  # 获取所需要的材料
  # return: {price => 111, name => '', requireds => {1 => {price => 111, name => '', requireds => {}, vigor_cost_per => 20}, vigor_cost_per =>20, } }
  # basic_material 是指是否需要再获取直接原材料的下一层材料，默认不需要获取，输入多久则需要获取多少层, only_requireds 只返回需要的材料信息
  def get_requireds(basic_material = 0, only_requireds = false)
    basic_material = basic_material.to_i
    self_requireds = {price: self.price, name: self.name, vigor_cost: vigor_cost.to_f, requireds: {}}
    product_to_products.includes(:required).each_with_index do |ptp, index|
      self_requireds[:requireds][index] = {}
      self_requireds[:requireds][index][:price] = ptp.required.try(:price).to_f
      self_requireds[:requireds][index][:name] = ptp.required.try(:name)
      self_requireds[:requireds][index][:vigor_cost] = (ptp.required.try(:vigor_cost_per) * ptp.amount).to_f
      self_requireds[:requireds][index][:amount] = ptp.amount
      # 递归获取下层原材料
      if ptp.required.try(:compile_flag) && basic_material > 0
        # 中间材料变成了product才能正常关联到其下一层的材料
        as_product = Product.new(ptp.required.attributes)
        self_requireds[:requireds][index][:requireds] = as_product.try(:get_requireds, basic_material - 1, true)
      end
    end
    if only_requireds
      self_requireds[:requireds]
    else
      self_requireds
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
    Product.transaction do 
      ImportErrorUtils.open(namespace: 'product', original_filename: file_name) do |eu|
        CSV.foreach(File.join(CSV_IMPORT_DIR, file_name), encoding: 'gb2312:utf-8').with_index do |row, index|
          next if index == 0
          params = get_csv_params(row)
          # row = encoding(row)
          # 交易行物品
          product_param = params[:product_param]
          # 价格
          price_param = params[:price_param]

          product = Product.find_or_initialize_by(:name => product_param[:name])
          product.attributes = product_param
          price = Price.new(price_param)
          
          if product.valid?
            product.save(validate: false)
            price.product = product
            if price.valid?
              price.save(validate: false)
            else
              eu.puts(index+1, price.errors)
            end
          else
            eu.puts(index+1, product.errors)
          end
        end
      end
    end
  end

  # 加编码
  def self.encoding row = []
    row.collect{|s| s.force_encoding('gb2312').encode('utf-8')}
  end
end
