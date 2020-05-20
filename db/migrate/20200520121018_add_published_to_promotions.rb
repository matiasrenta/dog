class AddPublishedToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :published, :boolean, default: :false
  end
end
