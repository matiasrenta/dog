class UpdateInvGroupedsToVersion2 < ActiveRecord::Migration
  def change
    update_view :inv_groupeds, version: 2, revert_to_version: 1
  end
end
