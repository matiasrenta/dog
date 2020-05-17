class CreateInvGroupeds < ActiveRecord::Migration
  def change
    create_view :inv_groupeds
  end
end
