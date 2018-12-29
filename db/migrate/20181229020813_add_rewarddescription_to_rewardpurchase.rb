class AddRewarddescriptionToRewardpurchase < ActiveRecord::Migration[5.0]
  def change
    add_column :rewardpurchases, :rewarddescription, :string
  end
end
