class ProductBox < ActiveRecord::Base
  belongs_to :product
  belongs_to :box

  validates :stock_min, numericality: true, if: -> {stock_min.present?}
  validates :stock_max, numericality: true, if: -> {stock_max.present?}
  validates :box_id, uniqueness: { scope: :product_id }
end
