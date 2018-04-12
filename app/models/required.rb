class Required < Product
  has_many :product_to_products
  has_many :products, :through => :product_to_products
end