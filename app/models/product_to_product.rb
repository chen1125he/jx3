class ProductToProduct < ApplicationRecord
  belongs_to :product, :foreign_key => :product_id
  belongs_to :required, :foreign_key => :required_id
end
