SYSTEM_PRICE_DATA = JSON.parse(File.read(Rails.root.join('db/fixtures/data/system_prices.json')))

ActiveRecord::Base.transaction do
  SYSTEM_PRICE_DATA.each do |data|
    owner = Product.find_by(name: data['owner_name'])

    data['system_prices'].each do |price|
      Price.seed(:owner_id, :price_type, :currency_type) do |p|
        p.owner_id = owner.id
        p.price_type = :system_price
        p.amount = price['amount']
        p.currency_type = price['currency_type']
      end
    end
  end
end
