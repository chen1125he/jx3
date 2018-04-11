class ProductToProduct < ApplicationRecord
  belongs_to :product
  belongs_to :required
end
