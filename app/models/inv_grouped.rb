class InvGrouped < ActiveRecord::Base

  belongs_to :product
  belongs_to :box

  def readonly?
    true
  end
end