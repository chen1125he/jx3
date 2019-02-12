# frozen_string_literal: true

class Admin::GenerateBulkImportProductTemplatesService
  def call(options = {})
    filename = format('物品导入模板_%<timestamp>s', timestamp: Time.current.strftime('%Y%m%d%H%M%S%L%N'))

    file = [%w[分类名 文件名 平均生成数量]]

    if options[:platform_windows]
      {
        filename: filename.encode('GBK', invalid: :replace, undef: :replace),
        file: file
      }
    else
      { filename: filename, file: file }
    end
  end
end
