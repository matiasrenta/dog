class InvGrouped < ActiveRecord::Base

  belongs_to :product
  belongs_to :box

  def self.stock_available(product_id, box_id)
    where(product_id: product_id, box_id: box_id).sum(:quantity_available)
  end

  def readonly?
    true
  end
end