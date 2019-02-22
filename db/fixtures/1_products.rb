PRODUCT_DATA = JSON.parse(File.read(Rails.root.join('db/fixtures/data/products.json')))

ActiveRecord::Base.transaction do
  PRODUCT_DATA.each do |data|
    category = Category.seed(:name) do |c|
                 c.name = data['category_name']
               end

    data['products'].each do |product|
      Product.seed(:name, :category_id) do |p|
        p.category_id = category[0].id
        p.name = product['name']
        p.avg_amount = product['avg_amount']
        p.price_type = product['price_type'] if product['price_type']
      end
    end
  end
end
