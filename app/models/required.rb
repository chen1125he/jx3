class Required < Product
  has_and_belongs_to_many :products, :join_table => 'product_to_products'
end