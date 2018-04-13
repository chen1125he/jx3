class ImportErrorUtils

	attr_accessor :csv
	attr_accessor :args
	attr_accessor :options
	attr_accessor :original_filename
	attr_accessor :error_msg_path

	ERROR_MSG_PATH = File.join(Rails.root, 'error_msg_path')

	def initialize(*args)
		options = if args.last.is_a? Hash then args.pop else Hash.new end
		self.csv = nil
		self.args = *args
		self.options = options
	end

	def puts(line_num, errors, file_name = nil)
		unless self.csv.present?
			self.csv = CSV.open(*self.args, self.options) # path, a+, {encoding: 'gb2312'}
			self.csv << ['文件名', '行号', '详情']
		end

		case errors
			when ActiveModel::Errors
				errors_obj = errors.full_messages
			when String
				errors_obj = [errors]
			else
				errors = errors
		end
		errors_obj.each do |error|
			self.csv << [file_name.present? ? file_name : self.original_filename, "#{line_num}行", error.strip]
		end
	end
	alias_method :add,   :puts
	alias_method :write, :puts

	def close
		self.csv.close unless self.csv.nil?
	end


	def self.error_msg_path(path, original_filename='')
		path = File.join(ERROR_MSG_PATH, path, Time.now.strftime('%Y%m%d'))
		FileUtils.mkdir_p(path) unless File.exist?(path)
		File.join(path, "#{original_filename}_#{SecureRandom.uuid}.csv")
	end



	def self.open(*args)
		options = if args.last.is_a? Hash then args.pop else Hash.new end

		file_path = options.delete(:file_path)
		original_filename = options.delete(:original_filename)
		file_path ||= self.error_msg_path("#{options.delete(:namespace)}", original_filename)

		args << file_path if args.size == 0
		args << 'a+'      if args.size == 1
		args << {encoding: 'gb2312'}.merge(options)

		begin
			error = new(*args)
			error.error_msg_path = file_path
			error.original_filename = original_filename
		rescue Exception => e
			error.csv.close if error.present?
			raise
		end

		if block_given?
			begin
				yield error
			ensure
				error.close
			end
		end
		error
	end
end