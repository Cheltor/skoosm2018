class AddBusinessIdToRewards < ActiveRecord::Migration[5.0]
  def change
    add_column :rewards, :business_id, :integer
  end
end
