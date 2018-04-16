class Price < ApplicationRecord
	belongs_to :product

	CSV_IMPORT_DIR = File.join(Rails.root, 'price_csv_import_dir')
	CSV_EXPORT_DIR = File.join(CSV_IMPORT_DIR, 'csv_export_dir')
	CSV_FIELDS = {
		product_params: {
			product_name: 0
		},
		price_params: {
			amount: 1,
			record_time: 2,
			seller_name: 3,
			update_flag: 4
		}
	}

	validates :product_id, presence: true

	attr_accessor :update_flag

	# csv导入
	def self.csv_import
		FileUtils.mkdir_p(CSV_IMPORT_DIR) unless File.exist?(CSV_IMPORT_DIR)
		files = Dir.glob(File.join(CSV_IMPORT_DIR, '*.csv'))
		files.each do |file|
			Price.transaction do 
				error_flag = false # 默认是false, 有error的时候设定为true
				ImportErrorUtils.open(namespace: 'price', original_filename: File.basename(file)) do |eu|
					CSV.foreach(file, encoding: 'gb2312:utf-8').with_index do |row, index|
						next if index == 0
						params = get_csv_params(row)
						product = Product.where(name: params[:product_params][:product_name]).first

						price = Price.new(params[:price_params])
						price.product = product
						if price.valid?
							price.save(validate: false)
							product.update_attribute(:price, price.amount)
						else
							error_flag = true
							eu.puts(index+1, price.errors)
						end
					end
				end
				raise ActiveRecord::Rollback if error_flag
			end
		end
	end

	# 导出价格csv
  # [product_name, price, record_time, seller_name, update_flag: 1]
  def self.csv_export
    FileUtils.mkdir_p(CSV_EXPORT_DIR) unless File.exist?(CSV_EXPORT_DIR)
    path = File.join(CSV_EXPORT_DIR, "price_#{Time.now.strftime('%Y%m%d%H%M%S')}.csv")
    CSV.open(path, 'a+') do |csv|
      csv << ['交易行名称(name)', '当前价格(amont)', '当前时间(record_time)', '售卖者(seller_name)', '是否更新此行价格']
      Product.find_in_batches(batch_size: 50) do |products|
        products.each do |product|
          csv << [product.name, product.price, Time.now.strftime('%Y/%m/%d %H:%M'), nil, 1]
        end
      end
    end
    path
  end
end
