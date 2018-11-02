class CreateRewardpurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :rewardpurchases do |t|
      t.references :reward, foreign_key: true
      t.references :user, foreign_key: true
      t.string :rewardname
      t.string :rewardbusiness
      t.integer :rewardcost

      t.timestamps
    end
  end
end
