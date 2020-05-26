class InvGrouped < ActiveRecord::Base

  belongs_to :product
  belongs_to :box

  def self.stock_available(product_id, box_id)
    where(product_id: product_id, box_id: box_id).sum(:quantity_available)
  end

  def quantity_taken
    OrderDetail.created.by_product_id(self.product_id).by_box_id(self.box_id).sum(:quantity)
  end

  def quantity_promoted
    Promotion.by_product(self.product_id).by_box(self.box_id).sum(:quantity_available)
  end

  def quantity_warehouse
    self.quantity_available + self.quantity_taken + self.quantity_promoted
  end

  def readonly?
    true
  end
end