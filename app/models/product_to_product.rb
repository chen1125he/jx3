# == Schema Information
#
# Table name: product_to_products
#
#  id          :integer          not null, primary key
#  product_id  :integer
#  required_id :integer
#  amount      :integer          default(1)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted     :boolean          default(FALSE)
#

class ProductToProduct < ApplicationRecord
  belongs_to :product, :foreign_key => :product_id
  belongs_to :required, :foreign_key => :required_id

  CSV_IMPORT_DIR = File.join(Rails.root, 'ptp_csv_import_dir')
  CSV_FIELDS = {product_name: 0, required_name: 1, amount: 2}

  attr_accessor :product_name, :required_name

  validate :product_present
  validate :required_present
  validates :amount, numericality: {only_integer: true, allow_blank: true, greater_than_or_equal_to: 1}

  # 验证product是否存在
  def product_present
  	unless product_id.present? || product_name.present?
		errors.add(:product_id, I18n.t(:blank))
		return
  	end
  	unless product.present?
  		errors.add(:product_id, I18n.t(:not_exists))
  	end
  end
  # 验证required是否存在
  def required_present
  	unless required_id.present? || required_name.present?
		errors.add(:required_id, I18n.t(:blank))
		return
  	end
  	unless required.present?
  		errors.add(:required_id, I18n.t(:not_exists))
  	end
  end


  #csv导入[商品名, 材料名, 数量]
  def self.csv_import
  	FileUtils.mkdir_p(CSV_IMPORT_DIR) unless File.exist?(CSV_IMPORT_DIR)
  	files = Dir.glob(File.join(CSV_IMPORT_DIR, '*.csv'))
  	files.each do |file|
  		ProductToProduct.transaction do 
  			error_flag = false # 默认是false, 有error的时候设定为true
			ImportErrorUtils.open(namespace: 'product_to_product', original_filename: File.basename(file)) do |eu|
				CSV.foreach(file, encoding: 'gb2312:utf-8').with_index do |row, index|
					next if index == 0
					params = get_csv_params(row)
					product = Product.where(name: params[:product_name]).first
					required = Required.where(name: params[:required_name]).first

					# 如果关联已经存在就做更新(数量)
					ptp = ProductToProduct.find_or_initialize_by(product_id: product.try(:id), required_id: required.try(:id))
					ptp.attributes = params
					ptp.product = product
					ptp.required = required
					unless ptp.save
						error_flag = true
						eu.puts(index+1, ptp.errors)
					end
				end
			end
			# 如果某个文件有数据导入失败，则此文件的所有数据都不导入
			raise ActiveRecord::Rollback if error_flag 
		end
  	end
  end
end
