class Admin::BulkEditProductTagsService
  def initialize(products, tag_ids, type)
    @products = products
    @tag_ids = tag_ids
    @type = type
  end

  def call
    @products.each do |product|
      tag_ids = product.product_tags.pluck(:tag_id)

      if @type.to_s == 'add'
        tag_ids = (tag_ids + @tag_ids).uniq
      elsif @type.to_s == 'remove'
        tag_ids = (tag_ids - @tag_ids).uniq
      end

      product.tags = Tag.where(id: tag_ids)
    end
  end
end
