class AddExpdateToReward < ActiveRecord::Migration[5.0]
  def change
    add_column :rewards, :expdate, :datetime
  end
end
